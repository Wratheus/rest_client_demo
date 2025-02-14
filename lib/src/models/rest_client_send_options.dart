import 'package:rest_client_demo/src/rest_client.dart';

/// [RestClient] request additional parameters that can be passed in each requests
///
/// [cancelToken] possibility to cancel request before it was processed.
///
/// [enableOverlayLoader] enables ui overlay screen with loading animation,
/// used for situation where don't have LoadingState or having this will be exceeded.
final class RestClientSendOptions {
  const RestClientSendOptions(
      {this.cancelToken, this.enableOverlayLoader = false});

  /// [cancelToken] possibility to cancel request before it was processed.
  final Object? cancelToken;

  /// [enableOverlayLoader] enables ui overlay screen with loading animation.
  final bool enableOverlayLoader;

  @override
  String toString() =>
      'RestClientSendOptions{cancelToken: $cancelToken, overlayLoader: $enableOverlayLoader}';
}
