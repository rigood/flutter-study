import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/repos/auth_repo.dart';
import 'package:threads/view_models/users_vm.dart';
import 'package:threads/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();

    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);

    state = await AsyncValue.guard(() async {
      final userCredential = await _repository.emailSignUp(
        form['email'],
        form['password'],
      );

      await users.createProfile(userCredential);
    });

    if (state.hasError && context.mounted) {
      showFirebaseErrorSnack(context, state.error);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvder = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
