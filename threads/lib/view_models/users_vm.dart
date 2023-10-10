import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/models/user_profile_model.dart';
import 'package:threads/repos/auth_repo.dart';
import 'package:threads/repos/user_repo.dart';

class UsersViewModel extends AutoDisposeAsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository
          .findProfile(_authenticationRepository.user!.uid);

      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("계정이 생성되지 않았습니다.");
    }

    state = const AsyncValue.loading();

    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "Anonmyous@anonmyous.com",
      name: credential.user!.displayName ?? "Anonmyous",
      bio: "undefined",
      link: "undefined",
    );

    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider =
    AsyncNotifierProvider.autoDispose<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
