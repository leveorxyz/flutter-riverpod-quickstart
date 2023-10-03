// ignore_for_file: always_use_package_imports

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/app.dart';
import 'bootstrap.dart';
import 'flavor/flavor.dart';

void main() async {
  await dotenv.load();
  final devConfig = EnvConfig(
    // appName: 'KStrings.appname',
    appName: 'app-name-stage',
    shouldCollectCrashLog: true,
    baseUrl: dotenv.env['BASEURL_PRODUCTION']!,
    hiveBoxName: dotenv.env['HIVE_PRODUCTION']!,
  );

  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: devConfig,
  );

  await bootstrap(() => const App());
}
