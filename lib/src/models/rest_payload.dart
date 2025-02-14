import 'package:rest_client_demo/src/models/rest_message_from_server.dart';

/// Represents the payload of a REST response, containing both data and messages.
final class RestPayload {
  /// Creates a REST response payload.
  ///
  /// - [content]: The unparsed response data from the server.
  /// - [messages]: A list of messages received from the server, defaults to an empty list.
  const RestPayload({
    this.content,
    this.messages = const [],
  });

  /// Creates an instance from a JSON object.
  ///
  /// This method should be implemented based on the API response format.
  factory RestPayload.fromJson(Map<String, dynamic> json) {
    // TODO: Implement JSON parsing based on API response structure.
    throw UnimplementedError();
  }

  /// The raw response data from the server.
  final Object? content;

  /// A list of messages received from the server.
  final List<RestMessageFromServer> messages;

  @override
  String toString() => 'RestPayload{content: $content, messages: $messages}';
}
