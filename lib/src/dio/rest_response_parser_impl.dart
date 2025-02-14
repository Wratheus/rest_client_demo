import 'package:rest_client_demo/src/exceptions/client_exceptions.dart';
import 'package:rest_client_demo/src/exceptions/data_parsing_exceptions.dart';
import 'package:rest_client_demo/src/exceptions/network_exceptions.dart';
import 'package:rest_client_demo/src/exceptions/server_exceptions.dart';
import 'package:rest_client_demo/src/models/rest_exception.dart';
import 'package:rest_client_demo/src/models/rest_message_from_server.dart';
import 'package:rest_client_demo/src/models/rest_payload.dart';
import 'package:rest_client_demo/src/models/rest_response.dart';
import 'package:rest_client_demo/src/rest_response_parser.dart';
import 'package:rest_client_demo/src/rest_ui_notifier.dart';

/// Implementation of [RestResponseParser] that handles parsing of responses from the server.
class RestResponseParserImpl implements RestResponseParser {
  const RestResponseParserImpl({
    required this.uiNotifier, // UI notifier for handling messages.
  });

  final RestUiNotifier
      uiNotifier; // UI notifier to update UI with server messages.

  @override
  Future<RestResponse> call(RestResponse response) async {
    // Parse the response payload (throws RestClientDataParsingException on failure).
    final RestPayload? payload = parsePayload(response.data);
    if (payload != null) {
      // Handle any messages from the server (throws RestClientDataParsingException on failure).
      await uiNotifier.handleMessagesFromServer(payload.messages);
    }

    // Parse the status code and possibly throw exceptions based on it.
    // Throws exceptions based on REST API status codes.
    final RestClientException? exception = parseStatusCode(
      response.statusCode,
      payload: payload,
      // Notify user with status code errors only if the server didn't provide error messages.
      viewType: uiNotifier.messagesHasErrors(payload)
          ? null // No notification if error messages are present.
          : RestMessageViewType.dialog, // Show dialog if no error messages.
    );
    if (exception != null) {
      throw exception;
    }

    // Parse headers from the response (throws RestClientHeadersParsingException on failure).
    parseHeaders(response.headers);

    // Return a parsed response with the appropriate data and status details.
    return RestResponse(
      data: payload?.content, // Extract content from the parsed payload.
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      headers: response.headers,
    );
  }

  @override
  void parseHeaders(Map<String, dynamic> headers) {
    try {
      // Implement header parsing logic here.
    } on Object catch (e, trace) {
      // Handle errors in parsing headers by throwing a RestClientHeadersParsingException.
      throw RestClientHeadersParsingException(
        originalException: e,
        stackTrace: trace,
        userViewType: RestMessageViewType.dialog,
      );
    }
  }

  @override
  RestPayload? parsePayload(Object? body) {
    if (body is Map<String, dynamic>) {
      try {
        // Parse the body into a RestPayload object if it's a Map.
        return RestPayload.fromJson(body);
      } on Object catch (e, trace) {
        // Handle errors during payload parsing.
        throw RestClientBodyParsingException(
          originalException: e,
          stackTrace: trace,
          userViewType: RestMessageViewType.dialog,
        );
      }
    }
    return null; // Return null if the body is not a Map.
  }

  @override
  RestClientException? parseStatusCode(
    int? statusCode, {
    required RestPayload? payload,
    required RestMessageViewType? viewType,
    StackTrace? stackTrace,
  }) {
    // If status code is not provided, throw a RestClientUnsupportedStatusCodeException.
    if (statusCode == null) {
      return RestClientUnsupportedStatusCodeException(
        stackTrace: stackTrace,
        userViewType: viewType,
      );
    }

    // If status code is between 200 and 300, it's valid, so return null.
    if (statusCode >= 200 && statusCode < 300) {
      return null;
    }

    // Map common HTTP error codes to corresponding exceptions.
    return switch (statusCode) {
      400 => RestClientBadRequestException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      401 => RestClientUnauthorizedAccessException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      403 => RestClientForbiddenAccessException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      404 => RestClientResourceNotFoundException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      409 => RestClientConflictErrorException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      408 => RestClientRequestTimeoutException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      405 => RestClientMethodNotAllowedException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      415 => RestClientUnsupportedMediaTypeException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      418 => RestClientImTeapotException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      422 => RestClientValidationErrorException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      429 => RestClientTooManyRequestsException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      500 => RestClientInternalServerErrorException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      501 => RestClientNotImplementedException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      502 => RestClientBadGatewayException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      503 => RestClientServerMaintenanceException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      504 => RestClientGatewayTimeoutException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      507 => RestClientInsufficientStorageException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      508 => RestClientLoopDetectedException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      510 => RestClientNotExtendedException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      526 => RestClientInvalidSslCertificateException(
          stackTrace: stackTrace,
          userViewType: viewType,
        ),
      _ => RestClientBadResponseException(stackTrace: StackTrace.current),
    };
  }
}
