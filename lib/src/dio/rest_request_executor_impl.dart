import 'package:dio/dio.dart';
import 'package:rest_client_demo/src/models/rest_client_send_options.dart';
import 'package:rest_client_demo/src/models/rest_content_type.dart';
import 'package:rest_client_demo/src/models/rest_response.dart';
import 'package:rest_client_demo/src/rest_request_executor.dart';
import 'package:rest_client_demo/src/rest_ui_notifier.dart';

/// Implementation of [RestRequestExecutor], responsible for making HTTP requests using Dio.
class RestRequestExecutorImpl implements RestRequestExecutor {
  /// Constructor initializes the [RestUiNotifier] and Dio interceptors.
  RestRequestExecutorImpl({
    required RestUiNotifier restUiNotifier,
    required List<Interceptor> interceptors,
  }) : _restUiNotifier = restUiNotifier {
    dio..interceptors.addAll(interceptors);
    // Interceptors such as sentry can be added here.
  }

  final RestUiNotifier
      _restUiNotifier; // Handles UI notifications like loading state.
  final Dio dio = Dio(); // Dio instance for making HTTP requests.

  /// Executes the HTTP request with the provided parameters.
  ///
  /// [path] - The endpoint URL.
  /// [method] - The HTTP method (e.g., GET, POST).
  /// [headers] - The headers to be included in the request.
  /// [contentType] - The content type (optional).
  /// [body] - The request body (optional).
  /// [queryParams] - The query parameters (optional).
  /// [options] - Additional options like cancel token or overlay loader.
  @override
  Future<RestResponse> call({
    required String path,
    required String method,
    required Map<String, String> headers,
    RestContentType? contentType,
    Map<String, Object?>? body,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  }) async {
    try {
      // Set default options if not provided.
      options ??= const RestClientSendOptions();
      CancelToken? cancelToken;

      // Extract cancel token from options if provided.
      if (options.cancelToken is CancelToken?) {
        cancelToken = options.cancelToken as CancelToken?;
      }

      // Set headers for the request, including the content type if specified.
      final Map<String, Object> sendHeaders = headers;
      if (contentType != null) {
        sendHeaders['Content-Type'] = switch (contentType) {
          RestContentType.formData => 'multipart/form-data', // Handle form data
          RestContentType.json => 'application/json', // Handle JSON data
        };
      }

      // Notify UI that the request is starting if overlay loader is enabled.
      if (options.enableOverlayLoader) {
        _restUiNotifier.onRequestStartCallback(cancelToken);
      }

      // Make the HTTP request using Dio.
      final Response<Map<String, dynamic>> result = await dio.request(
        path,
        data: contentType != null
            ? contentType(body)
            : null, // Format body based on content type
        options: Options(
          method: method,
          headers: sendHeaders,
          sendTimeout:
              const Duration(seconds: 30), // Timeout for sending the request
          receiveTimeout:
              const Duration(seconds: 60), // Timeout for receiving the response
        ),
        queryParameters: queryParams,
        cancelToken:
            cancelToken, // Attach cancel token for request cancellation
      );

      // Return a custom RestResponse object with the result data.
      return RestResponse(
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
        headers: result.headers.map,
      );
    } on DioException catch (_) {
      // Rethrow DioException to be handled by the calling code.
      rethrow;
    } finally {
      // Notify UI that the request has ended if overlay loader was enabled.
      if (options?.enableOverlayLoader ?? false) {
        _restUiNotifier.onRequestEndCallback();
      }
    }
  }

  /// Downloads a file from the specified [url] to [savePath] and reports progress.
  ///
  /// [url] - The file URL to download.
  /// [savePath] - The path where the file should be saved.
  /// [onReceiveProgress] - Callback for reporting download progress.
  @override
  Future<RestResponse> download({
    required String url,
    required String savePath,
    required void Function(int received, int total) onReceiveProgress,
  }) async {
    // Perform the download using Dio.
    final Response<dynamic> result = await dio.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress, // Handle progress updates
    );

    // Return a custom RestResponse object with the download result data.
    return RestResponse(
      data: result.data,
      statusMessage: result.statusMessage,
      statusCode: result.statusCode,
      headers: result.headers.map,
    );
  }
}
