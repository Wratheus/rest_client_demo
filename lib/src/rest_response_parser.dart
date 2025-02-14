import 'package:rest_client_demo/src/models/rest_exception.dart';
import 'package:rest_client_demo/src/models/rest_message_from_server.dart';
import 'package:rest_client_demo/src/models/rest_payload.dart';
import 'package:rest_client_demo/src/models/rest_response.dart';

/// Parses REST responses into a standardized format.
abstract interface class RestResponseParser {
  /// Parses the given [response] and returns a structured [RestResponse].
  Future<RestResponse> call(RestResponse response);

  /// Parses an HTTP status code and returns a corresponding exception if applicable.
  RestClientException? parseStatusCode(
    int? statusCode, {
    required RestPayload? payload,
    required RestMessageViewType? viewType,
    StackTrace? stackTrace,
  });

  /// Extracts relevant information from response [headers].
  void parseHeaders(Map<String, dynamic> headers);

  /// Converts a response [body] into a [RestPayload].
  RestPayload? parsePayload(Object? body);
}
