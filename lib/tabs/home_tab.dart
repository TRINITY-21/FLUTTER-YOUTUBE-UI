import 'dart:io';

import 'package:Youtube/api/network_handler.dart';
import 'package:Youtube/models/listModel.dart';
import 'package:Youtube/models/videosModel.dart';
import 'package:Youtube/pages/details_page.dart';
import 'package:Youtube/providers/date.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeTab extends StatefulWidget {
  VideosModel uploadModel;

  HomeTab({this.uploadModel});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // List<Widget> getVideos() {
  //   List<Video> videos = generateVideos();
  //   List<Widget> videosWidgetList = [];

  //   videosWidgetList.add(Container(
  //     padding: EdgeInsets.only(top: 10, bottom: 10),
  //     color: Color(0xFF212121),
  //     child: Suggestions(),
  //   ));

  //   for (Video video in videos) {
  //     videosWidgetList.add(VideoWidget());
  //   }

  //   return videosWidgetList;
  // }

  // List<String> videosList = [
  //   "Justice League: Trailer",
  //   "Flutter vs React Native",
  //   "Best laptop for programming",
  //   "Eminem: Space Bound",
  //   "Get started with competitive programming",
  //   "How to ace the coding interview!",
  //   "Queen: Bohemian Rhapsody",
  //   "Avengers Endgame: Trailer"
  // ];

  // List<Users> usersList = [
  //   Users(name: "HBOMax", image: AssetImage("assets/0.jpg")),
  //   Users(name: "Jason smith", image: AssetImage("assets/1.jpg")),
  //   Users(name: "Jackson", image: AssetImage("assets/2.jpg")),
  //   Users(name: "Eminem vevo", image: AssetImage("assets/3.jpg")),
  //   Users(name: "Max", image: AssetImage("assets/4.jpg")),
  //   Users(name: "Miller", image: AssetImage("assets/5.jpg")),
  //   Users(name: "Queen vevo", image: AssetImage("assets/6.jpg")),
  //   Users(name: "Marvel", image: AssetImage("assets/7.jpg"))
  // ];

  // List<Video> generateVideos() {
  //   Random random = new Random();
  //   List<Video> vids = [];
  //   for (int i = 0; i < videosList.length; i++) {
  //     vids.add(Video(
  //         AssetImage("assets/" + i.toString() + ".jpg"),
  //         random.nextInt(10000000) + 1000,
  //         DateTime.now().subtract(Duration(days: random.nextInt(1000) + 10)),
  //         videosList[i],
  //         usersList[i]));
  //   }
  //   return vids;
  // }

  UploadDate date;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        height: MediaQuery.of(context).size.height - 550,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 150,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text("All",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF909090),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 120,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Center(
                  child: Text("Today",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF909090),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 120,
              margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              child: Center(
                  child: Text("Trending",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF909090),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 120,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Center(
                  child: Text("Learning",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF909090),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 120,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Center(
                  child: Text("Live",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF909090),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 120,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Center(
                  child: Text("Watched",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF909090),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ],
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: widget.uploadModel.videos.length,
            itemBuilder: (context, index) {
              ListModel videos = widget.uploadModel.videos[index];
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(videoId: videos.id)));
                      },
                      child: Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkHandler().getImage(videos.thumbnail),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: 35,
                              child: CircleAvatar(
                                backgroundImage:
                                    FileImage(File(videos.writer.image)),
                              ),
                            ),
                            Container()
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(videos.title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Helvetica",
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.normal)),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(videos.writer.name,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Helvetica",
                                            color: Color(0xFF909090))),
                                    Text(" ∙ ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Helvetica",
                                            color: Color(0xFF909090))),
                                    Text(videos.views.toString() + " views",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Helvetica",
                                            color: Color(0xFF909090))),
                                    Text(" ∙ ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Helvetica",
                                            color: Color(0xFF909090))),
                                    Text(
                                     getTimeSinceUpload(videos.createdAt),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Helvetica",
                                          color: Color(0xFF909090)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              );
            }),
      )
    ]);


  }
    String getTimeSinceUpload(String uploadedDate) {
     DateTime date = DateTime.parse(uploadedDate);
    DateTime now = DateTime.now();
    int minutes = now.difference(date).inMinutes;

    int hours = now.difference(date).inHours;
    int days = now.difference(date).inDays;
    double weeks = days / 7;
    double months = weeks / 4;
    double years = days /365;

    if (years >= 1) {
      String year = " year";
      if (years >= 2) {
        year = " years";
      }
      return years.toInt().toString() + year;
    } else if (months >= 1){
      String month = " month";
      if (months >= 2) {
        month = " months";
      }
      return months.toInt().toString() + month;
    } else if (weeks >= 1){
      String week = " week";
      if (weeks >= 2) {
        week = " weeks";
      }
      return weeks.toInt().toString() + week;
    } else if (days >= 1){
      String day = " day";
      if (days >= 2) {
        day = " days";
      }
      return days.toInt().toString() + day;
    } else if (hours >= 1){
      String hour = " hour";
      if (hours >= 2) {
        hour = " hours";
      }
      return hours.toInt().toString() + hour;
    } else if (minutes >= 1){
      String minute = " minute";
      if (minutes >= 2) {
        minute = " minutes";
      }
      return minutes.toInt().toString() + minute;
    } else {
      return "not long";
    }
  }
  }
 

