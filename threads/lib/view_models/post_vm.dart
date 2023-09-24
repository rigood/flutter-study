import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/models/post_model.dart';
import 'package:threads/repos/post_repo.dart';

class PostViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _repository;
  List<PostModel> _list = [];

  @override
  FutureOr<List<PostModel>> build() async {
    _repository = ref.read(postRepo);
    final result = await _repository.fetchPosts();
    final newList = result.docs.map(
      (doc) => PostModel.fromJson(
        doc.data(),
      ),
    );
    _list = newList.toList();
    return _list;
  }

  Future<void> searchPosts(String query) async {
    final result = await _repository.searchPosts(query);
    final newList = result.docs.map(
      (doc) => PostModel.fromJson(
        doc.data(),
      ),
    );
    _list = newList.toList();
    state = AsyncValue.data(_list);
  }
}

final postProvider = AsyncNotifierProvider<PostViewModel, List<PostModel>>(
  () => PostViewModel(),
);
