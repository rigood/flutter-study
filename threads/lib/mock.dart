import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> mockData = [
  {
    "userAvatar": "assets/images/cocomong.jpg",
    "userName": "cocomong",
    "userSubname": "Coco",
    "followers": "26.6K",
    "hasFollowersAvatar": false,
    "icon": FontAwesomeIcons.heart,
    "iconBackgroundColor": Colors.pink,
    "hours": 4,
    "activity": "Replies",
    "activityMessage": "Mentioned you",
    "activityDescription":
        "Here's a thread you should follow if you love @cocomong",
  },
  {
    "userAvatar": "assets/images/1.jpg",
    "userName": "jin",
    "userSubname": "Jin uk",
    "followers": "789K",
    "hasFollowersAvatar": true,
    "icon": FontAwesomeIcons.user,
    "iconBackgroundColor": Colors.green,
    "hours": 4,
    "activity": "Mentions",
    "activityMessage": "Replied to you",
    "activityDescription": "Count me in!",
  },
  {
    "userAvatar": "assets/images/2.jpg",
    "userName": "mandu",
    "userSubname": "Mandu jin",
    "followers": "301K",
    "hasFollowersAvatar": false,
    "icon": FontAwesomeIcons.rotateLeft,
    "iconBackgroundColor": Colors.blue,
    "hours": 4,
    "activity": "Following",
    "activityMessage": "Follwed you",
    "activityDescription": "",
  }
];
