import 'package:flutter/material.dart';

class MovieYoutubeThumbnail extends StatelessWidget {
  final String youtubeId;

  const MovieYoutubeThumbnail({
    super.key,
    required this.youtubeId,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network("https://img.youtube.com/vi/$youtubeId/0.jpg");
  }
}
