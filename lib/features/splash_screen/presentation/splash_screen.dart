import 'package:app_ui/app_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_ddd/features/splash_screen/splash_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  static String get path => '/splashScreen';
  static String get name => '/splashScreen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sTate = ref.watch(splashNotifierProvider);

    return Scaffold(
      body: Center(
        child: Image.asset(
          Images.logo,
          fit: BoxFit.cover,
          width: 0.6.sw,
        ).animate().scale(
              begin: Offset.zero,
              duration: const Duration(seconds: 3),
            ),
      ),
    );
  }
}
