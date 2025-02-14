import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rest_client_demo/src/exceptions/client_exceptions.dart';
import 'package:rest_client_demo/src/exceptions/network_exceptions.dart';
import 'package:rest_client_demo/src/models/rest_exception.dart';
import 'package:rest_client_demo/src/models/rest_message_from_server.dart';
import 'package:rest_client_demo/src/models/rest_response.dart';
import 'package:rest_client_demo/src/rest_exception_handler.dart';
import 'package:rest_client_demo/src/rest_response_parser.dart';

/// Handles exceptions at the raw DIO level.
class RestExceptionHandlerImpl implements RestExceptionHandler {
  const RestExceptionHandlerImpl({required this.responseParser});

  final RestResponseParser responseParser;

  /// Always throws a [RestClientException], unless a valid response is returned
  /// from [checkIfResponseWasValid].
  @override
  Future<RestResponse> call(Exception exception) async {
    if (exception is! DioException) {
      // If the exception is not of type DioException, throw a generic exception
      throw RestClientUnknownRequestException(
        originalException: exception,
        stackTrace: StackTrace.current,
      );
    }

    // Check if the response is valid
    final RestResponse? checkResult = await checkIfResponseWasValid(exception);
    if (checkResult != null) {
      return checkResult; // Return the valid response if available
    }

    RestClientException? restException;

    // Handle different types of DioException
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        restException = RestClientConnectionTimeoutException(
          originalException: exception,
          stackTrace: exception.stackTrace,
        );
        break;
      case DioExceptionType.sendTimeout:
        restException = RestClientSendTimeoutException(
          originalException: exception,
          stackTrace: exception.stackTrace,
        );
        break;
      case DioExceptionType.receiveTimeout:
        restException = RestClientReceiveTimeoutException(
          originalException: exception,
          stackTrace: exception.stackTrace,
        );
        break;
      case DioExceptionType.badCertificate:
        restException = RestClientInvalidCertificateException(
          originalException: exception,
          stackTrace: exception.stackTrace,
        );
        break;
      case DioExceptionType.badResponse:
        restException = responseParser.parseStatusCode(
          exception.response?.statusCode,
          stackTrace: exception.stackTrace,
          viewType: RestMessageViewType.dialog,
          payload: null,
        );
        break;
      case DioExceptionType.cancel:
        restException = RestClientActionCanceledException(
          originalException: exception,
          stackTrace: exception.stackTrace,
        );
        break;
      case DioExceptionType.connectionError:
        restException = RestClientNetworkConnectionException(
          originalException: exception,
          stackTrace: exception.stackTrace,
        );
        break;
      case DioExceptionType.unknown:
        restException = RestClientUnknownRequestException(
          originalException: exception,
          stackTrace: exception.stackTrace,
        );
        break;
    }

    // Handle HandshakeException errors
    if (exception.error is HandshakeException) {
      restException = RestClientHandshakeFailureException(
        originalException: exception,
        stackTrace: exception.stackTrace,
      );
    }

    // If no specific exception was found, throw a generic one
    if (restException == null) {
      throw RestClientUnknownRequestException(
        originalException: exception,
        stackTrace: exception.stackTrace,
      );
    }

    // Throw the specific RestClientException
    throw restException;
  }

  /// This method checks if the response was valid by parsing the data.
  /// If the response contains a 'message' field, it is considered valid.
  Future<RestResponse?> checkIfResponseWasValid(
    DioException dioException,
  ) async {
    // Check if the response data is in the expected format
    if (dioException.response?.data is! Map<String, dynamic>) {
      return null; // Return null if the data format is unexpected
    }

    // Cast response data to Map
    final Response<Map<String, dynamic>> mapResponse = Response(
      data: dioException.response!.data as Map<String, dynamic>,
      requestOptions: dioException.response!.requestOptions,
      statusMessage: dioException.response!.statusMessage,
      statusCode: dioException.response!.statusCode,
      isRedirect: dioException.response!.isRedirect,
      redirects: dioException.response!.redirects,
      extra: dioException.response!.extra,
      headers: dioException.response!.headers,
    );

    // Check if the response contains a 'message' list
    if (mapResponse.data?['message'] is List<dynamic>) {
      final List<dynamic> messages =
          mapResponse.data?['message'] as List<dynamic>;
      if (messages.isNotEmpty) {
        // Parse the response and return it if valid
        return responseParser(
          RestResponse(
            data: mapResponse.data,
            statusCode: mapResponse.statusCode,
            statusMessage: mapResponse.statusMessage,
            headers: mapResponse.headers.map,
          ),
        );
      }
    }

    return null; // Return null if the response is not valid
  }
}
