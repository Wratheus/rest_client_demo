import 'package:rest_client_demo/src/models/rest_exception.dart';
import 'package:rest_client_demo/src/models/rest_message_from_server.dart';

/// Thrown when an unsupported HTTP status code is returned by the server.
final class RestClientUnsupportedStatusCodeException
    extends RestClientException {
  const RestClientUnsupportedStatusCodeException({
    super.userViewType,
    super.originalException,
    super.stackTrace,
  });
}

/// Thrown when the HTTP status code is 2xx but the response payload is null.
final class RestClientBadResponseException extends RestClientException {
  const RestClientBadResponseException({
    super.originalException,
    super.stackTrace,
    super.userViewType,
  });
}

/// Thrown when an internal server error (status code 500) occurs.
final class RestClientInternalServerErrorException extends RestClientException {
  const RestClientInternalServerErrorException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when a bad gateway error (status code 502) occurs.
final class RestClientBadGatewayException extends RestClientException {
  const RestClientBadGatewayException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the "I'm a teapot" status code (418) is returned by the server.
final class RestClientImTeapotException extends RestClientException {
  const RestClientImTeapotException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the server is undergoing maintenance (status code 503).
final class RestClientServerMaintenanceException extends RestClientException {
  const RestClientServerMaintenanceException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when a gateway timeout error (status code 504) occurs.
final class RestClientGatewayTimeoutException extends RestClientException {
  const RestClientGatewayTimeoutException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when a conflict error (status code 409) occurs.
final class RestClientConflictErrorException extends RestClientException {
  const RestClientConflictErrorException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when too many requests (status code 429) are sent to the server.
final class RestClientTooManyRequestsException extends RestClientException {
  const RestClientTooManyRequestsException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when there is insufficient storage on the server (status code 507).
final class RestClientInsufficientStorageException extends RestClientException {
  const RestClientInsufficientStorageException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when a loop is detected in the request (status code 508).
final class RestClientLoopDetectedException extends RestClientException {
  const RestClientLoopDetectedException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when an extension required by the request is not supported (status code 510).
final class RestClientNotExtendedException extends RestClientException {
  const RestClientNotExtendedException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}
