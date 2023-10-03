import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_ddd/core/di.dart';
import 'package:riverpod_ddd/features/home_page/presentation/home_screen.dart';
import 'package:riverpod_ddd/features/login_page/presentation/login_screen.dart';
import 'package:riverpod_ddd/features/splash_screen/domain/splash_screen_dom.dart';
import 'package:riverpod_ddd/features/splash_screen/presentation/spash_state.dart';
import 'package:riverpod_ddd/local_cache/cache_provider.dart';
import 'package:riverpod_ddd/router/router.dart';

final splashNotifierProvider =
    StateNotifierProvider<SpalashNotifier, SplashState>((ref) {
  return SpalashNotifier(
    domain: sl(),
    ref: ref,
  )..init();
});

class SpalashNotifier extends StateNotifier<SplashState> {
  SpalashNotifier({required SplashDomain domain, required Ref ref})
      : _domain = domain,
        _ref = ref,
        super(SplashState.init());
  final SplashDomain _domain;
  final Ref _ref;

  Future<void> init() async {
    // await _domain.permissionCheck();
    // await _domain.versionCheck();
    _domain.showNotification();

    await Future<void>.delayed(const Duration(seconds: 3));

    if (_ref.watch(hiveProvider).token.isNotEmpty) {
      _ref.watch(routerProvider).goNamed(HomeScreen.name);
    } else {
      _ref.watch(routerProvider).goNamed(LoginScreen.name);
    }
  }
}
