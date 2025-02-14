import 'dart:convert';

/// Defines the content type of a REST request.
///
/// - [json]: Encodes the request body as a JSON string.
/// - [formData]: Encodes the request body as FormData.
enum RestContentType {
  formData,
  json;

  /// Converts the request [body] into the appropriate format based on the content type.
  ///
  /// - If [json], the body is encoded as a JSON string.
  /// - If [formData], the body is converted using [FormData.formDataEncode].
  ///
  /// Returns `null` if the body is `null`.
  Object? call(Map<String, dynamic>? body) {
    if (body == null) return null;
    return switch (this) {
      RestContentType.formData => FormData.formDataEncode(body),
      RestContentType.json => jsonEncode(body),
    };
  }
}

/// Utility class for handling FormData encoding.
class FormData {
  /// Encodes the given [body] as FormData.
  ///
  /// This method should be implemented to convert the body into a format
  /// suitable for `multipart/form-data` requests.
  ///
  /// Currently, it throws an [UnimplementedError].
  static List<int> formDataEncode(Map<String, dynamic>? body) {
    // TODO: Implement FormData encoding or use a library.
    throw UnimplementedError();
  }
}
