import 'package:riverpod_ddd/core/network/network.dart';
import 'package:riverpod_ddd/features/login_page/domain/user_profile_model.dart';

// ignore: one_member_abstracts
abstract class LoginRepo {
  Future<Either<CleanFailure, UserProfileModel>> login({
    required String email,
    required String password,
  });
}

class LoginI implements LoginRepo {
  @override
  Future<Either<CleanFailure, UserProfileModel>> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    // HERE API WILL BE IMPLEMENTED
    return const Right(
      UserProfileModel(
        userName: 'user1',
        accesToken: 'accesstoken',
        refreshToken: 'refreshToken',
      ),
    );
  }
}
