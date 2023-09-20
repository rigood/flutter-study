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
}

final postRepo = Provider((ref) => PostRepository());
