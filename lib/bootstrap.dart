// ignore_for_file: noop_primitive_operations, always_use_package_imports

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_ddd/local_cache/cache_provider.dart';

import 'core/di.dart' as di;
import 'core/network/network.dart';
import 'flavor/build_config.dart';

class ProviderLog extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Logger.i('''
{
  "PROVIDER": "${provider.name}; ${provider.runtimeType.toString()}"

}''');
    log('$newValue');
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final container = ProviderContainer(
    observers: [ProviderLog()],
  );

  Logger.init(
    true, // isEnable ，if production ，please false
    isShowFile: false, // In the IDE, whether the file name is displayed
    isShowTime: false, // In the IDE, whether the time is displayed
    levelDebug: 15,
    levelInfo: 10,
    levelWarn: 5,
    phoneVerbose: Colors.white,
    phoneDebug: const Color(0xff27AE60),
    phoneInfo: const Color(0xff2F80ED),
    phoneWarn: const Color(0xffE2B93B),
    phoneError: const Color(0xffEB5757),
  );

  final box = container.read(hiveProvider);

  // Add cross-flavor Hive BoxName
  final boxName = BuildConfig.instance.config.hiveBoxName;

  await box.init(boxName);

  // Add cross-flavor API BASE URL
  // You can use any of bellowed API handler.

  // API HANDLER :: 01
  // NetworkHandler.instance.setup(
  //   baseUrl: BuildConfig.instance.config.baseUrl,
  // );

  const username = 'mobile';
  const password = 'secret';

  // API HANDLER :: 02
  ApiHandler.instance.setUp(
    setupConfiguration: BaseOptions(
      baseUrl: BuildConfig.instance.config.baseUrl,
    ),
    basicHeaderPart: {
      HttpHeaders.authorizationHeader:
          "Basic ${base64Encode(utf8.encode("$username:$password"))}",
    },
    token: '',
    interceptor: CustomInterceptors(),
  );

  await di.init();

  runApp(
    ProviderScope(
      parent: container,
      observers: [ProviderLog()],
      child: await builder(),
    ),
  );
}
