import 'package:get_it/get_it.dart';
import 'package:riverpod_ddd/features/login_page/data/login_repo.dart';
import 'package:riverpod_ddd/features/splash_screen/domain/splash_screen_dom.dart';
import 'package:riverpod_ddd/local_cache/cache_abstract.dart';
import 'package:riverpod_ddd/local_cache/cache_handler.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton<CacheHandler>(CacheHandlerI.new)
    ..registerLazySingleton<SplashDomain>(SplashDomI.new)
    ..registerLazySingleton<LoginRepo>(LoginI.new);
}
