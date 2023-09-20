class PostModel {
  final String text;
  final String creatorName;
  final String creatorUid;
  final String? imgUrl;
  final int createdAt;

  PostModel({
    required this.text,
    required this.creatorName,
    required this.creatorUid,
    this.imgUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "creatorName": creatorName,
      "creatorUid": creatorUid,
      "imgUrl": imgUrl,
      "createdAt": createdAt,
    };
  }
}
