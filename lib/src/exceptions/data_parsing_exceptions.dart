import 'package:rest_client_demo/src/models/rest_exception.dart';

/// Thrown when there is an error parsing the response body.
final class RestClientBodyParsingException extends RestClientException {
  const RestClientBodyParsingException({
    required super.originalException,
    required super.stackTrace,
    required super.userViewType,
  });
}

/// Thrown when there is an error parsing the response headers.
final class RestClientHeadersParsingException extends RestClientException {
  const RestClientHeadersParsingException({
    required super.originalException,
    required super.stackTrace,
    required super.userViewType,
  });
}

/// Thrown when a map was expected in the response, but something else was received.
final class RestClientExpectedMapException extends RestClientException {
  const RestClientExpectedMapException({
    required super.originalException,
    required super.stackTrace,
    required super.userViewType,
  });
}

/// Thrown when a list was expected in the response, but something else was received.
final class RestClientExpectedListException extends RestClientException {
  const RestClientExpectedListException({
    required super.originalException,
    required super.stackTrace,
    required super.userViewType,
  });
}

/// Thrown when a boolean was expected in the response, but something else was received.
final class RestClientExpectedBoolException extends RestClientException {
  const RestClientExpectedBoolException({
    required super.originalException,
    required super.stackTrace,
    required super.userViewType,
  });
}
