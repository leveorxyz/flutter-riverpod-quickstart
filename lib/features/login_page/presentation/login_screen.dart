import 'package:app_ui/app_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_ddd/features/login_page/presentation/login_state_notifier.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  static String get path => '/loginScreen';
  static String get name => '/loginScreen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(loginProvider.notifier);
    final sTate = ref.watch(loginProvider);

    return Scaffold(
      appBar: const KAppBar(titleText: 'Login'),
      body: Center(
        child: Column(
          children: [
            gap48,
            Padding(
              padding: padding10,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  elevation: MaterialStateProperty.all(8.r),
                ),
                onPressed: !sTate.isLoading
                    ? () => controller.login(
                          email: 'user@gmail.com',
                          password: '123456',
                        )
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Login'),
                    gap10,
                    if (sTate.isLoading)
                      Padding(
                        padding: paddingV4,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
