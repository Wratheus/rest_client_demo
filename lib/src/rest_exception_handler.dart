import 'package:rest_client_demo/src/models/rest_response.dart';

/// Handles the adaptation of low-level HTTP exceptions to [RestClientException].
abstract interface class RestExceptionHandler {
  /// Converts an [Exception] into a standardized REST response.
  ///
  /// Throws a [RestClientException] if the exception is recognized.
  Future<RestResponse> call(Exception exception);
}
