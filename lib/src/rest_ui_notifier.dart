import 'package:rest_client_demo/src/models/rest_message_from_server.dart';
import 'package:rest_client_demo/src/models/rest_payload.dart';

/// You can use this class callbacks, and scale or override it's functional
/// to provide your custom behavior to rest request cycle.
///
/// Handles UI notifications related to REST requests.
class RestUiNotifier {
  /// Creates a notifier for tracking request lifecycle events and handling server messages.
  const RestUiNotifier({
    required this.onRequestStartCallback,
    required this.onRequestEndCallback,
    required this.handleMessagesFromServer,
  });

  /// Called when a request starts, optionally passing a [cancelToken].
  final void Function(Object? cancelToken) onRequestStartCallback;

  /// Called when a request ends.
  final void Function() onRequestEndCallback;

  /// Handles messages received from the server.
  final Future<void> Function(List<RestMessageFromServer> messages)
      handleMessagesFromServer;

  /// Checks if the response payload contains error messages.
  bool messagesHasErrors(RestPayload? payload) {
    if (payload?.messages.isNotEmpty ?? false) {
      for (final RestMessageFromServer message in payload!.messages) {
        if (message.typeMessage == RestMessageType.error) {
          return true;
        }
      }
    }
    return false;
  }
}
