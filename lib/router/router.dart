import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_ddd/features/home_page/presentation/home_screen.dart';
import 'package:riverpod_ddd/features/login_page/presentation/login_screen.dart';
import 'package:riverpod_ddd/features/splash_screen/presentation/splash_screen.dart';
import 'package:riverpod_ddd/flavor/flavor.dart';
import 'package:riverpod_ddd/local_cache/cache_provider.dart';
import 'package:riverpod_ddd/local_cache/cache_tags.dart';
import 'package:riverpod_ddd/router/error_page.dart';
import 'package:riverpod_ddd/router/router_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = ref.watch(routerNotifierProvider)..init();

  return GoRouter(
    debugLogDiagnostics:
        BuildConfig.instance.environment != Environment.PRODUCTION,
    refreshListenable: router,
    routes: [
      GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: LoginScreen.path,
        name: LoginScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
    ],
    initialLocation: SplashScreen.path,
    errorPageBuilder: router._errorPageBuilder,
    redirect: (context, state) {
      final loggedIn = router.isLoggedIn;
      final routeInQ = router.nonAuthedList.contains(state.matchedLocation);
      log(
        'loggedIn : $loggedIn || routeInQ : $routeInQ',
        name: '------------------|',
      );

      if (loggedIn) {
        return null;
      } else {
        if (routeInQ) {
          return null;
        } else {
          return '/loginScreen';
          // return null;
        }
      }
      // return null;
    },
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _isLoggedIn = _ref.watch(hiveProvider).token.isNotEmpty;
  }
  final Ref _ref;

  void init() {
    _ref.watch(hiveProvider).getCacheBox().watch().listen((_) {
      if (_.key == KCacheTags.token || _.deleted) {
        _isLoggedIn = _ref.watch(hiveProvider).token.isNotEmpty;
        notifyListeners();
      }
    });
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  List<String> nonAuthedList = [
    SplashScreen.path,
    LoginScreen.path,
    '/nonAuthPage1',
    '/nonAuthPage2',
    '/nonAuthPage3',
    '/nonAuthPage4',
  ];

  Page<void> _errorPageBuilder(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: ErrorPage(
            state: state,
          ),
        ),
      );
}
