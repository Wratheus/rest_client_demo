import 'package:rest_client_demo/src/models/rest_exception.dart';
import 'package:rest_client_demo/src/models/rest_message_from_server.dart';

/// Thrown when a connection timeout occurs while making a request.
final class RestClientConnectionTimeoutException extends RestClientException {
  const RestClientConnectionTimeoutException({
    super.sentryCapture = false,
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.toast,
  });
}

/// Thrown when there is a network connection issue during a request.
final class RestClientNetworkConnectionException extends RestClientException {
  const RestClientNetworkConnectionException({
    super.sentryCapture = false,
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.toast,
  });
}

/// Thrown when a request times out before receiving a response.
final class RestClientRequestTimeoutException extends RestClientException {
  const RestClientRequestTimeoutException({
    super.sentryCapture = false,
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the request exceeds the time limit for sending data.
final class RestClientSendTimeoutException extends RestClientException {
  const RestClientSendTimeoutException({
    super.sentryCapture = false,
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.toast,
  });
}

/// Thrown when the request exceeds the time limit for receiving data.
final class RestClientReceiveTimeoutException extends RestClientException {
  const RestClientReceiveTimeoutException({
    super.sentryCapture = false,
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.toast,
  });
}

/// Thrown when an invalid SSL certificate is encountered.
final class RestClientInvalidCertificateException extends RestClientException {
  const RestClientInvalidCertificateException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the handshake during SSL/TLS connection fails.
final class RestClientHandshakeFailureException extends RestClientException {
  const RestClientHandshakeFailureException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}

/// Thrown when the SSL certificate is invalid.
final class RestClientInvalidSslCertificateException
    extends RestClientException {
  const RestClientInvalidSslCertificateException({
    super.originalException,
    super.stackTrace,
    super.userViewType = RestMessageViewType.dialog,
  });
}
