import 'package:ubenwa/domain/domain.dart';

class UnauthrizedException extends AppException {
  UnauthrizedException({super.message, super.response});
}

class NotInternetException extends AppException {
  NotInternetException({super.message, super.response});
}

class NotFoundException extends AppException {
  NotFoundException({super.message, super.response});
}

class RedirectException extends AppException {
  RedirectException({super.message, super.response});
}

class ForbiddenException extends AppException {
  ForbiddenException({super.message, super.response});
}

class TimeOutException extends AppException {
  TimeOutException({super.message, super.response});
}

class BadRequestException extends AppException {
  BadRequestException({super.message, super.response});
}

class DeviceException extends AppException {
  DeviceException({super.message, super.response});
}

class AppException implements Exception {
  final AppHttpResponse? response;
  final String? message;
  AppException({
    this.response,
    this.message,
  });
}
