import 'package:dio/dio.dart';
import 'package:rest_client_demo/src/models/rest_client_send_options.dart';
import 'package:rest_client_demo/src/models/rest_content_type.dart';
import 'package:rest_client_demo/src/models/rest_response.dart';
import 'package:rest_client_demo/src/rest_client.dart';
import 'package:rest_client_demo/src/rest_exception_handler.dart';
import 'package:rest_client_demo/src/rest_request_executor.dart';
import 'package:rest_client_demo/src/rest_response_parser.dart';

class RestClientImpl implements RestClient {
  const RestClientImpl({
    required this.executor,
    required this.parser,
    required this.handler,
    required this.getBaseHeaders,
    required this.basePath,
  });

  final RestRequestExecutor executor;
  final RestResponseParser parser;
  final RestExceptionHandler handler;
  final Map<String, String> Function() getBaseHeaders;
  final String basePath;

  // Sends a request with the specified method and parameters
  Future<RestResponse> sendRequest({
    required String method,
    required String path,
    required RestContentType? contentType,
    Map<String, String>? headers,
    Map<String, Object?>? body,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  }) async {
    try {
      final Map<String, String> sendHeaders = getBaseHeaders();
      if (headers != null) {
        sendHeaders.addAll(headers);
      }
      final RestResponse response = await executor(
        path: '$basePath/$path',
        method: method,
        headers: sendHeaders,
        queryParams: queryParams,
        body: body,
        options: options,
        contentType: contentType,
      );

      return parser(response);
    } on DioException catch (dioException) {
      return handler(dioException);
    }
  }

  @override
  // Makes a GET request
  Future<RestResponse> get({
    required String path,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  }) async =>
      sendRequest(
        method: 'GET',
        path: path,
        headers: headers,
        queryParams: queryParams,
        options: options,
        contentType: null,
      );

  @override
  // Makes a POST request
  Future<RestResponse> post({
    required String path,
    required Map<String, Object?> body,
    RestContentType contentType = RestContentType.json,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  }) async =>
      sendRequest(
        method: 'POST',
        path: path,
        body: body,
        headers: headers,
        queryParams: queryParams,
        options: options,
        contentType: contentType,
      );

  @override
  // Makes a PUT request
  Future<RestResponse> put({
    required String path,
    required Map<String, Object?> body,
    RestContentType contentType = RestContentType.json,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  }) async =>
      sendRequest(
        method: 'PUT',
        path: path,
        body: body,
        headers: headers,
        queryParams: queryParams,
        options: options,
        contentType: contentType,
      );

  @override
  // Makes a DELETE request
  Future<RestResponse> delete({
    required String path,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  }) async =>
      sendRequest(
        method: 'DELETE',
        path: path,
        headers: headers,
        queryParams: queryParams,
        options: options,
        contentType: null,
      );

  @override
  // Makes a HEAD request
  Future<RestResponse> head({
    required String path,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  }) async =>
      sendRequest(
        method: 'HEAD',
        path: path,
        headers: headers,
        queryParams: queryParams,
        options: options,
        contentType: null,
      );

  @override
  // Makes a PATCH request
  Future<RestResponse> patch({
    required String path,
    required Map<String, Object?> body,
    RestContentType contentType = RestContentType.json,
    Map<String, String>? headers,
    Map<String, Object?>? queryParams,
    RestClientSendOptions? options,
  }) async =>
      sendRequest(
        method: 'PATCH',
        path: path,
        body: body,
        headers: headers,
        queryParams: queryParams,
        options: options,
        contentType: contentType,
      );

  @override
  // Downloads a file from the server
  Future<RestResponse> download({
    required String url,
    required String savePath,
    required void Function(int received, int total) onReceiveProgress,
  }) async {
    try {
      return await executor.download(
        url: '$basePath$url',
        savePath: savePath,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (dioException) {
      return handler(dioException);
    }
  }
}
