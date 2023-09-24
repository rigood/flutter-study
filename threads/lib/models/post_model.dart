class PostModel {
  final String text;
  final String creatorName;
  final String creatorUid;
  final String creatorAvatar;
  final String imgUrl;
  final int replies;
  final int likes;
  final int createdAt;

  PostModel({
    required this.text,
    required this.creatorName,
    required this.creatorUid,
    required this.creatorAvatar,
    required this.imgUrl,
    required this.replies,
    required this.likes,
    required this.createdAt,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        creatorName = json["creatorName"],
        creatorUid = json["creatorUid"],
        creatorAvatar = json["creatorAvatar"],
        imgUrl = json["imgUrl"],
        replies = json["replies"],
        likes = json["likes"],
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "creatorName": creatorName,
      "creatorUid": creatorUid,
      "creatorAvatar": creatorAvatar,
      "imgUrl": imgUrl,
      "replies": replies,
      "likes": likes,
      "createdAt": createdAt,
    };
  }
}
