import 'dart:core';

import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:master_layout/master_layout_component.dart';
import 'package:config/config_service.dart';
import 'logger_component.dart';
import 'package:auth/auth_service.dart';
import 'package:alert/alert_service.dart';
import 'package:aside/aside_service.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
    'true';

@Component(selector: 'app')
@View(
    template: '<master-layout><logger></logger></master-layout>',
    directives: const [MasterLayoutComponent, LoggerComponent])
class AppComponent {}

main() async {
  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(MasterLayoutComponent),
    const Provider(AuthenticationService),
    const Provider(AuthorizationService),
    const Provider(AlertService),
    const Provider(AsideService),
    const Provider(ConfigService),
    provide(Client, useFactory: () => new BrowserClient(), deps: [])
  ]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
  }
}
