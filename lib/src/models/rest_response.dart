import 'package:rest_client_demo/src/exceptions/data_parsing_exceptions.dart';
import 'package:rest_client_demo/src/exceptions/server_exceptions.dart';
import 'package:rest_client_demo/src/models/rest_message_from_server.dart';

/// Represents a REST API response.
final class RestResponse {
  /// Creates an instance of a REST response.
  ///
  /// - [headers]: The response headers.
  /// - [data]: The response body (optional).
  /// - [statusCode]: The HTTP status code (optional).
  /// - [statusMessage]: The HTTP status message (optional).
  const RestResponse({
    required this.headers,
    this.data,
    this.statusCode,
    this.statusMessage,
  });

  /// The response body.
  final Object? data;

  /// The HTTP status code of the response.
  final int? statusCode;

  /// The HTTP status message of the response.
  final String? statusMessage;

  /// The response headers.
  final Map<String, dynamic> headers;

  /// Checks if the response status code indicates success (2xx).
  ///
  /// Throws a [RestClientUnsupportedStatusCodeException] if the status code is `null`.
  bool get isSuccess {
    if (statusCode == null) {
      throw const RestClientUnsupportedStatusCodeException();
    }
    return statusCode! >= 200 && statusCode! <= 299;
  }

  /// Converts the response [data] to a [Map<String, dynamic>].
  ///
  /// Throws a [RestClientExpectedMapException] if the conversion fails.
  Map<String, dynamic> get dataAsMap {
    try {
      return data! as Map<String, dynamic>;
    } on Object catch (e, trace) {
      throw RestClientExpectedMapException(
        originalException: e,
        stackTrace: trace,
        userViewType: RestMessageViewType.dialog,
      );
    }
  }

  /// Converts the response [data] to a [List<dynamic>].
  ///
  /// Throws a [RestClientExpectedListException] if the conversion fails.
  List<dynamic> get dataAsList {
    try {
      return data! as List<dynamic>;
    } on Object catch (e, trace) {
      throw RestClientExpectedListException(
        originalException: e,
        stackTrace: trace,
        userViewType: RestMessageViewType.dialog,
      );
    }
  }

  /// Converts the response [data] to a [bool].
  ///
  /// Throws a [RestClientExpectedBoolException] if the conversion fails.
  bool get dataAsBool {
    try {
      return data! as bool;
    } on Object catch (e, trace) {
      throw RestClientExpectedBoolException(
        originalException: e,
        stackTrace: trace,
        userViewType: RestMessageViewType.dialog,
      );
    }
  }

  @override
  String toString() => 'RestResponse{data: $data, '
      'statusCode: $statusCode, '
      'statusMessage: $statusMessage}';
}
