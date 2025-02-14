/// Defines how a message should be displayed.
///
/// - [dialog]: The message appears in a dialog.
/// - [toast]: The message appears as a toast notification.
enum RestMessageViewType { dialog, toast }

/// Represents the type of a server message.
///
/// - [success]: Indicates a successful operation.
/// - [warning]: Indicates a warning.
/// - [error]: Indicates an error.
enum RestMessageType { success, warning, error }

/// Represents a message received from the server.
final class RestMessageFromServer {
  /// Creates a server message with the specified properties.
  const RestMessageFromServer({
    required this.typeMessage,
    required this.typeView,
    required this.text,
  });

  /// Creates an instance from a JSON object.
  ///
  /// This method should be implemented based on the API response format.
  factory RestMessageFromServer.fromJson(Map<String, dynamic> json) {
    // TODO: Implement JSON parsing based on API response structure.
    throw UnimplementedError();
  }

  /// Type of the message (e.g., success, warning, error).
  final RestMessageType typeMessage;

  /// Display type of the message (e.g., dialog, toast).
  final RestMessageViewType typeView;

  /// Message content.
  final String text;
}
