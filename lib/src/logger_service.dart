import 'dart:async';
import 'dart:convert';
import 'dart:mirrors';
import 'package:http/browser_client.dart';
import 'package:angular2/core.dart';

import 'package:config/config_service.dart';

import 'log_level.dart';

/**
 * Отправляет логи на сервер
 */
@Injectable()
class LoggerService {
  BrowserClient _http;
  ConfigService _config;

  LoggerService(this._config) {
    _http = new BrowserClient();
  }

  trace(String message) => _log(LogLevel.trace, message);

  debug(String message) => _log(LogLevel.debug, message);

  information(String message) => _log(LogLevel.information, message);

  warning(String message) => _log(LogLevel.warning, message);

  error(String message) => _log(LogLevel.error, message);

  critical(String message) => _log(LogLevel.critical, message);

  Future _log(LogLevel logLevel, String message) async {
    String minLogLevelString = await _config.Get<String>('log_level', 'error');
    LogLevel minLogLevel = enumFromString(minLogLevelString, LogLevel);

    if (logLevel.index <= minLogLevel.index)
      return null;

    String _backendUrl =
      await _config.Get<String>('backend_url', 'http://localhost:5000');

    try {
      await _http.post(_backendUrl +'/log',
        headers: {'Content-Type': 'application/json'},
        body: {"level": "${JSON.encode(logLevel)}", "message": "${JSON.encode(message)}"});
    } catch (e) {
      print('Failed to send log message to the server: $e');

      return new Exception(
        'Failed to send log message to the server. Cause: $e');
    }
  }
}

dynamic enumFromString(String value, t) {
  return (reflectType(t) as ClassMirror).getField(#values).reflectee.firstWhere((e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}