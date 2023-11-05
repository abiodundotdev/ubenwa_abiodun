import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:simpliapp/core/core.dart';

import 'package:simpliapp/domain/domain.dart';
import 'package:simpliapp/services/services.dart';

final _injector = GetIt.instance;

/// Service container for registering and and getting services
class SC {
  SC() {
    _injector.allowReassignment = true;
    if (!_injector.isRegistered<SC>(instance: this)) {
      _injector.registerFactory<SC>(() => this);
    }
  }

  static Future<void> initialize() async {
    SC()
      ..add<AppHttpClient>(
        DioHttpClient(
          await DioAdapter.make,
        ),
      )
      ..add<SessionStorage>(
        SessionStorage(),
      );
  }

  static SC get get => _injector.get<SC>();

  T getService<T extends Object>() => _injector.get<T>();

  void add<T extends Object>(T instance,
      {ServiceScope scope = ServiceScope.factory}) {
    if (scope.isFactory) {
      _injector.registerFactory<T>(() => instance);
      return;
    }
    _injector.registerSingleton(instance);
  }

  Future<void> replace<T extends Object>(T instance) async {
    try {
      await _injector.unregister<T>(instance: instance);
      _injector.registerSingleton<T>(instance);
      return;
    } catch (e) {
      return;
    }
  }

  @visibleForTesting
  void dispose() {
    _injector.reset();
  }
}

extension XSC on SC {
  SessionStorage get sessionStorage => _injector.get<SessionStorage>();
  // SharedPrefs get sharedPrefs => _injector.get<SharedPrefs>();
  // AppHttpClient get httpClient => _injector.get<AppHttpClient>();
  // AppServices get services => _injector.get<AppServices>();
  // AppNavigator get navigator => _injector.get<AppNavigator>();
}

class SessionStorage {
  final _user = ValueNotifier<dynamic>(null);
  final _token = ValueNotifier<String?>(null);
  ValueNotifier<String?> get token => _token;
  ValueNotifier<dynamic> get user => _user;

  ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.system);

  void setToken(String? token) {
    _token.value = token;
  }
}

ValueNotifier<String> tokenSession = ValueNotifier("");

enum ServiceScope {
  factory,
  singleton;

  bool get isFactory => this == ServiceScope.factory;
  bool get isSingleton => this == ServiceScope.singleton;
}

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
