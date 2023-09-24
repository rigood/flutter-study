import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadImageFile(File image, String uid) {
    final fileRef = _storage.ref().child(
        "images/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");

    return fileRef.putFile(image);
  }

  Future<void> uploadPost(PostModel data) async {
    await _db.collection("posts").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts() {
    return _db.collection("posts").orderBy("createdAt", descending: true).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchPosts(String query) {
    return _db
        .collection("posts")
        .where('text', isGreaterThanOrEqualTo: query)
        .where('text', isLessThanOrEqualTo: '$query\uF7FF')
        .get();
  }
}

final postRepo = Provider((ref) => PostRepository());

final postStream = StreamProvider.autoDispose<List<PostModel>>(
  (ref) {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    return db
        .collection("posts")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (doc) => PostModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  },
);
