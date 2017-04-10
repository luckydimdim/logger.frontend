import 'dart:async';
import 'dart:convert';

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
    LogLevel minLogLevel = logLevelFromString(_config.helper.minLogLevel);

    if (logLevel.index < minLogLevel.index)
      return null;

    String logLevelStr = logLevelToString(logLevel);

    // В дебаг-режиме дополнительно выводим сообщение в консоль
    if (!_config.helper.production)
      print('Sending logs to server. LogLevel: $logLevelStr. Message: $message.');

    String jsonText = JSON.encode(
        {"level": "$logLevelStr", "message": "$message"});

    try {
      await _http.post(
          _config.helper.logsUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonText);
    } catch (e) {
      print('Failed to send log message to the server: $e');

      return new Exception(
          'Failed to send log message to the server. Cause: $e');
    }
  }

  dynamic logLevelFromString(String value) {
    for (var level in LogLevel.values) {
      if (level.toString().split('.')[1].toUpperCase() == value.toUpperCase())
        return level;
    }

    throw new Exception('Unknown level: $value');
  }

  String logLevelToString(LogLevel logLevel) {
    return logLevel.toString().split('.')[1];
  }
}

