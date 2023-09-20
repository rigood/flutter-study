import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/models/post_model.dart';
import 'package:threads/repos/auth_repo.dart';
import 'package:threads/repos/post_repo.dart';
import 'package:threads/view_models/users_vm.dart';

class UploadPostViewModel extends AsyncNotifier<void> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  late final PostRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(postRepo);
  }

  Future<void> uploadPost(String text, File image, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;

    if (userProfile == null) return;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        final task = await _repository.uploadImageFile(image, user!.uid);

        if (task.metadata == null) return;

        await _repository.uploadPost(
          PostModel(
            text: text,
            creatorName: userProfile.name,
            creatorUid: user.uid,
            imgUrl: await task.ref.getDownloadURL(),
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      },
    );

    context.pushReplacement("/");
  }
}

final uploadPostProvider = AsyncNotifierProvider<UploadPostViewModel, void>(
  () => UploadPostViewModel(),
);
