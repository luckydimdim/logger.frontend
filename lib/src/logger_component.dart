import 'package:angular2/core.dart';
import 'logger_service.dart';

@Component(
    selector: 'logger',
    templateUrl: 'logger_component.html',
    providers: const [LoggerService])
class LoggerComponent {
  final LoggerService _logger;

  LoggerComponent(this._logger);

  void testLogger(String message) {
    _logger.information('asdasdasdasd');
  }
}