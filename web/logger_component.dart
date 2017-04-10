import 'dart:html';

import 'package:angular2/core.dart';
import 'package:logger/logger_service.dart';

@Component(
    selector: 'logger',
    templateUrl: 'logger_component.html',
    providers: const [LoggerService])
class LoggerComponent {
  final LoggerService _logger;

  String debugText;

  LoggerComponent(this._logger);

  void sendTrace(InputElement input) {
    debugText = '';
    try {
      _logger.trace(input.value);
      debugText = 'Успешно!';
    }
    catch (e) {
      debugText = e.toString();
    }
  }

  void sendDebug(InputElement input) {
    debugText = '';
    try {
      _logger.debug(input.value);
      debugText = 'Успешно!';
    }
    catch (e) {
      debugText = e.toString();
    }
  }

  void sendInformation(InputElement input) {
    debugText = '';
    try {
      _logger.information(input.value);
      debugText = 'Успешно!';
    }
    catch (e) {
      debugText = e.toString();
    }
  }

  void sendWarning(InputElement input) {
    debugText = '';
    try {
      _logger.warning(input.value);
      debugText = 'Успешно!';
    }
    catch (e) {
      debugText = e.toString();
    }
  }

  void sendError(InputElement input) {
    debugText = '';
    try {
      _logger.error(input.value);
      debugText = 'Успешно!';
    }
    catch (e) {
      debugText = e.toString();
    }
  }

  void sendCritical(InputElement input) {
    debugText = '';
    try {
      _logger.critical(input.value);
      debugText = 'Успешно!';
    }
    catch (e) {
      debugText = e.toString();
    }
  }
}
