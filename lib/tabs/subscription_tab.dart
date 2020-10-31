import 'dart:math';
import 'package:Youtube/Widgets/suggestions.dart';
import 'package:Youtube/Widgets/user_profile.dart';
import 'package:Youtube/Widgets/video_widget.dart';
import 'package:Youtube/models/users.dart';
import 'package:Youtube/models/video.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubscriptionsTab extends StatelessWidget {

  final Users currentUser = new Users(name: "Sam wilson", image: AssetImage("assets/9.jpg"));

  List<Widget> getVideos() {
    List<Video> videos = generateVideos();
    List<Widget> videosWidgetList = [];
  
    videosWidgetList.add(
      Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        color: Color(0xFF212121),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  UserProfile(currentUser: currentUser),
                ]
              ),
            ),
            Divider(color: Color(0xFF909090)),
            Suggestions()
          ],
        ),
      )
    );

    for (Video video in videos) {
      videosWidgetList.add(VideoWidget());
    }

    return videosWidgetList;
  }

  List<String> videosList = [
    "Justice League: Trailer",
    "Flutter vs React Native",
    "Best laptop for programming",
    "Eminem: Space Bound",
    "Get started with competitive programming",
    "How to ace the coding interview!",
    "Queen: Bohemian Rhapsody",
    "Avengers Endgame: Trailer"
  ];

  List<Users> usersList = [
    Users(name: "HBOMax", image: AssetImage("assets/0.jpg")),
    Users(name: "Jason smith", image: AssetImage("assets/1.jpg")),
    Users(name: "Jackson", image: AssetImage("assets/2.jpg")),
    Users(name: "Eminem vevo", image: AssetImage("assets/3.jpg")),
    Users(name: "Max", image: AssetImage("assets/4.jpg")),
    Users(name: "Miller", image: AssetImage("assets/5.jpg")),
    Users(name: "Queen vevo", image: AssetImage("assets/6.jpg")),
    Users(name: "Marvel", image: AssetImage("assets/7.jpg"))
  ];

  List<Video> generateVideos() {
    Random random = new Random();
    List<Video> vids = [];
    for (int i = 0; i < videosList.length; i++) {
      vids.add(Video(
        AssetImage("assets/" + i.toString() + ".jpg"),
        random.nextInt(10000000) + 1000,
        DateTime.now().subtract(Duration(days: random.nextInt(1000) + 10)),
        videosList[i],
        usersList[i]
      ));
    }
    return vids;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF212121),
      child: ListView(
        children: getVideos()
      ),
    );
  }
}