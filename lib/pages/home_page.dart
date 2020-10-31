import 'dart:io';
import 'package:Youtube/api/network_handler.dart';
import 'package:Youtube/models/registrationModel.dart';
import 'package:Youtube/models/uploadModel.dart';
import 'package:Youtube/models/users.dart';
import 'package:Youtube/models/videosModel.dart';
import 'package:Youtube/pages/upload_page.dart';
import 'package:Youtube/pages/user_profile.dart';
import 'package:Youtube/tabs/explore_tab.dart';
import 'package:Youtube/tabs/home_tab.dart';
import 'package:Youtube/tabs/library_tab.dart';
import 'package:Youtube/tabs/notification_tab.dart';
import 'package:Youtube/tabs/subscription_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NetworkHandler _networkHandler = NetworkHandler();
  RegistrationModel _userModel = RegistrationModel();
  UploadModel _uploadModel = UploadModel();

  /// get current user
  void getUser() async {
    final res = await _networkHandler.get('/api/users/auth');
    setState(() {
      _userModel = RegistrationModel.fromJson(res);
    });

    print(res);
    print('currUser ${_userModel.image}');
  }


  @override
  void initState() {
    super.initState();
    getUser();
    getVideo();
   
  }


  bool isLoaded = false;

  VideosModel _videos = VideosModel();

  void getVideo() async {
    var videos = await _networkHandler.get('/api/video/getVideos');
    setState(() {
      _videos = VideosModel.fromJson(videos);
      isLoaded = true;
    });

    print(_videos);
  }





  final Users currentUser =
      new Users(name: "Sam wilson", image: AssetImage("assets/9.jpg"));

  List<Widget> tabsList = [
    Tab(
      icon: Icon(Icons.home),
      text: "Home",
    ),
    Tab(
      icon: Icon(Icons.explore),
      text: "Explore",
    ),
    Tab(
      icon: Icon(Icons.subscriptions),
      text: "Subscriptions",
    ),
    Tab(
      icon: Icon(Icons.notifications),
      text: "Notifications",
    ),
    Tab(
      icon: Icon(Icons.video_library),
      text: "Library",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(width: 35.0, child: Image.asset("assets/logo.png")),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("YouTube",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadPage()));
                      },
                      child: Icon(Icons.file_upload)),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(Icons.search),
                  SizedBox(
                    width: 15.0,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserProfilePage(currentUser: _userModel)));
                      },
                      child: CircleAvatar(
                        backgroundImage: _userModel.image == null
                            ? currentUser.image
                            : FileImage(File(_userModel.image)),
                        radius: 20,
                      )),
                ],
              )
            ],
          ),
          backgroundColor: Color(0xFF24231E),
        ),
        body: isLoaded == true?
       
           TabBarView( 
            children: [
              HomeTab(uploadModel:_videos),
              ExploreTab(),
              SubscriptionsTab(),
              NotificationsTab(),
              LibraryTab()

              
            ],
          ) 
          
          
        
        
       
        : Center(child: CircularProgressIndicator()),
        bottomNavigationBar: TabBar(
          labelStyle: TextStyle(fontSize: 7, fontFamily: "Helvetica"),
          tabs: tabsList,
          labelColor: Color(0xFFFFFFFF),
          unselectedLabelColor: Color(0xFF909090),
          indicatorColor: Colors.transparent,
        ),
        backgroundColor: Color(0xFF282828),
      ),
    );
  }

  
}
