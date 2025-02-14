import 'package:rest_client_demo/src/models/rest_message_from_server.dart';
import 'package:rest_client_demo/src/models/rest_exception.dart';

/// Thrown when a request is unauthorized (HTTP 401).
final class RestClientUnauthorizedAccessException extends RestClientException {
  const RestClientUnauthorizedAccessException({
    super.sentryCapture = false,
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when a request is canceled by the user or system.
final class RestClientActionCanceledException extends RestClientException {
  const RestClientActionCanceledException({
    super.sentryCapture = false,
    super.originalException,
    super.stackTrace,
    super.userViewType,
  });
}

/// Thrown when an unknown error occurs during a request.
final class RestClientUnknownRequestException extends RestClientException {
  const RestClientUnknownRequestException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the server returns a bad request error (HTTP 400).
final class RestClientBadRequestException extends RestClientException {
  const RestClientBadRequestException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when access to a resource is forbidden (HTTP 403).
final class RestClientForbiddenAccessException extends RestClientException {
  const RestClientForbiddenAccessException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the requested resource is not found (HTTP 404).
final class RestClientResourceNotFoundException extends RestClientException {
  const RestClientResourceNotFoundException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when a request fails due to validation errors (HTTP 422).
final class RestClientValidationErrorException extends RestClientException {
  const RestClientValidationErrorException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the request method is not allowed (HTTP 405).
final class RestClientMethodNotAllowedException extends RestClientException {
  const RestClientMethodNotAllowedException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the requested feature is not implemented (HTTP 501).
final class RestClientNotImplementedException extends RestClientException {
  const RestClientNotImplementedException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the server does not support the media type (HTTP 415).
final class RestClientUnsupportedMediaTypeException
    extends RestClientException {
  const RestClientUnsupportedMediaTypeException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}
