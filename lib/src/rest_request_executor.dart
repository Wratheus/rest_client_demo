import 'package:rest_client_demo/src/models/rest_client_send_options.dart';
import 'package:rest_client_demo/src/models/rest_content_type.dart';
import 'package:rest_client_demo/src/models/rest_response.dart';

/// Executes REST requests with support for various HTTP methods.
abstract interface class RestRequestExecutor {
  /// Sends a request to the specified [path] using the given [method].
  ///
  /// Supports optional [headers], [body], [queryParams], [contentType], and additional [options].
  Future<RestResponse> call({
    required String path,
    required String method,
    required Map<String, String> headers,
    RestContentType? contentType,
    Map<String, Object?>? body,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  });

  /// Downloads a file from the given [url] and saves it to [savePath].
  ///
  /// The [onReceiveProgress] callback tracks progress updates.
  Future<RestResponse> download({
    required String url,
    required String savePath,
    required void Function(int received, int total) onReceiveProgress,
  });
}
