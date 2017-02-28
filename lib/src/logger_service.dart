import 'dart:async';
import 'dart:convert';
import 'package:json_object/json_object.dart';
import 'package:http/browser_client.dart';
import 'package:angular2/core.dart';

import 'log_level.dart';

@Injectable()
/**
 * Отправляет логи на сервер
 */
class LoggerService {
  static const _url = 'http://localhost:5000/log';
  BrowserClient _http;

  LoggerService() {
    _http = new BrowserClient();
  }

  trace(String message) => _log(LogLevel.trace, message);
  debug(String message) => _log(LogLevel.debug, message);
  information(String message) => _log(LogLevel.information, message);
  warning(String message) => _log(LogLevel.warning, message);
  error(String message) => _log(LogLevel.error, message);
  critical(String message) => _log(LogLevel.critical, message);

  Future _log(LogLevel logLevel, String message) async {
    try {
      /*var data = new JsonObject();
      data.level = logLevel;
      data.message = message;*/

      await _http.post(_url,
        /*headers: {'Content-Type': 'application/json'},*/
        body: {"level": "$logLevel", "message": "$message"});
    } catch (e) {
      print('Failed to send log message to the server: $e');

      return new Exception('Failed to send log message to the server. Cause: $e');
    }
  }
}