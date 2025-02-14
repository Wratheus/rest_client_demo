import 'package:rest_client_demo/src/models/rest_message_from_server.dart';

/// Base class for exceptions occurring in the REST client.
///
/// This class provides a common structure for handling errors in the REST client.
/// It includes information about the original exception, stack trace, user notification type,
/// and whether the error should be sent to Sentry.
abstract class RestClientException implements Exception {
  /// Creates a REST client exception.
  ///
  /// - [originalException]: The original exception that caused this error.
  /// - [stackTrace]: The stack trace associated with the error.
  /// - [userViewType]: Defines how the error should be displayed to the user (e.g., dialog, toast).
  /// - [sentryCapture]: Whether this error should be reported to Sentry (defaults to `false`).
  const RestClientException({
    required this.originalException,
    required this.stackTrace,
    required this.userViewType,
    this.sentryCapture = false,
  });

  /// The original exception that caused this error.
  final Object? originalException;

  /// The stack trace associated with the error.
  final StackTrace? stackTrace;

  /// Defines how the error should be displayed to the user.
  final RestMessageViewType? userViewType;

  /// Flag indicating whether the error should be sent to Sentry for tracking.
  final bool sentryCapture;

  @override
  String toString() =>
      'RestClientException{originalException: $originalException}';
}
