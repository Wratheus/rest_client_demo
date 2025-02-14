import 'package:rest_client_demo/src/models/rest_client_send_options.dart';
import 'package:rest_client_demo/src/models/rest_content_type.dart';
import 'package:rest_client_demo/src/models/rest_response.dart';

/// A REST client interface for making HTTP requests.
abstract interface class RestClient {
  /// Sends a GET request to the specified [path].
  ///
  /// Optionally, you can provide [headers], [queryParams], and additional [options].
  Future<RestResponse> get({
    required String path,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  });

  /// Sends a POST request to the specified [path] with a [body].
  ///
  /// The request body is encoded using [contentType] (defaults to JSON).
  /// Supports optional [headers], [queryParams], and additional [options].
  Future<RestResponse> post({
    required String path,
    required Map<String, Object?> body,
    RestContentType contentType = RestContentType.json,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  });

  /// Sends a PUT request to the specified [path] with a [body].
  ///
  /// Similar to [post], the body is encoded using [contentType] (defaults to JSON).
  Future<RestResponse> put({
    required String path,
    required Map<String, Object?> body,
    RestContentType contentType = RestContentType.json,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  });

  /// Sends a DELETE request to the specified [path].
  ///
  /// Supports optional [headers], [queryParams], and additional [options].
  Future<RestResponse> delete({
    required String path,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  });

  /// Sends a PATCH request to the specified [path] with a [body].
  ///
  /// Used to partially update a resource. Encodes the body using [contentType] (defaults to JSON).
  Future<RestResponse> patch({
    required String path,
    required Map<String, Object?> body,
    RestContentType contentType = RestContentType.json,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  });

  /// Sends a HEAD request to the specified [path].
  ///
  /// Similar to GET but retrieves only headers, without the response body.
  Future<RestResponse> head({
    required String path,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  });

  /// Downloads a file from the given [url] and saves it to [savePath].
  ///
  /// The [onReceiveProgress] callback provides real-time progress updates.
  Future<RestResponse> download({
    required String url,
    required String savePath,
    required void Function(int received, int total) onReceiveProgress,
  });
}
