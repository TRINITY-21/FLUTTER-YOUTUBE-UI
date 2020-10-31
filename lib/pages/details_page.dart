import 'dart:convert';
import 'dart:io';

import 'package:Youtube/api/network_handler.dart';
import 'package:Youtube/models/getVideo.dart';
import 'package:Youtube/models/likesModel.dart';
import 'package:Youtube/models/listModel.dart';
import 'package:Youtube/models/registrationModel.dart';
import 'package:Youtube/models/subscribeModel.dart';
import 'package:Youtube/models/uploadModel.dart';
import 'package:Youtube/models/video.dart';
import 'package:Youtube/providers/subscribe.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  String videoId;
  DetailsPage({this.videoId});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  NetworkHandler _networkHandler = NetworkHandler();
  RegistrationModel _userModel = RegistrationModel();
  ListModel listModel = ListModel();
  Subscribe _subscribe = Subscribe();
  LikesModel likesModel;

  int number = 0;
  bool subscribedVideo = false;
  int liked = 0;
  int disliked = 0;
  bool _liked = false;
  bool _disliked = false;

  GetVideoModel videoModel;
  Video _v;

  /// get current user
  void getUser() async {
    final res = await _networkHandler.get('/api/users/auth');
    setState(() {
      _userModel = RegistrationModel.fromJson(res);
    });

    print(res);
    print('currUser ${_userModel.image}');
  }

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    getUser();
    getVideo();
    changeSubscribeNum();
  }

  bool isLoaded = false;

  UploadModel video = UploadModel();

  void getVideo() async {
    videoModel = GetVideoModel(videoId: widget.videoId);

    var res = await _networkHandler.post(
        '/api/video/getVideo', json.encode(videoModel.toJson()));
    var video = json.decode(res.body);

    setState(() {
      videoModel = GetVideoModel.fromJson(video);
      //isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF24231E),
        body: isLoaded
            ? videoPlayer()
            : Center(child: CircularProgressIndicator()));
  }

  Widget videoPlayer() {
    return Column(children: [
      Container(
          color: Colors.brown,
          height: 300,
          width: 550,
          child: FittedBox(
            fit: BoxFit.contain,
            child: videoModel.video.filePath == null
                ? Chewie(
                    controller: ChewieController(
                    videoPlayerController: VideoPlayerController.file(
                        File(videoModel.video.filePath)),
                    aspectRatio: 3 / 2,
                    autoPlay: true,
                    looping: false,
                    showControls: true,
                    autoInitialize: true,
                  ))
                : Text('play'),
          )),
      Container(
        margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(children: <Widget>[
          // Column(
          //   children: <Widget>[
          //     Container(
          //       height: 55,
          //       width: 50,
          //       child: CircleAvatar(
          //         backgroundImage:
          //             FileImage(File(videoModel.video.writer.image)),
          //       ),
          //     ),
          //     Container()
          //   ],
          // ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(videoModel.video.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Helvetica",
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.normal)),
                  ],
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      // Text(videoModel.video.writer.name,
                      //     style: TextStyle(
                      //         fontSize: 14,
                      //         fontFamily: "Helvetica",
                      //         color: Color(0xFF909090))),
                      // Text(" ∙ ",
                      //     style: TextStyle(
                      //         fontSize: 14,
                      //         fontFamily: "Helvetica",
                      //         color: Color(0xFF909090))),
                      Text(videoModel.video.views.toString() + " views",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Helvetica",
                              color: Color(0xFF909090))),
                      Text(" ∙ ",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Helvetica",
                              color: Color(0xFF909090))),
                      Text(
                        getTimeSinceUpload(videoModel.video.createdAt) + ' ago',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Helvetica",
                            color: Color(0xFF909090)),
                      ),

                      Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 100),
                              // margin: EdgeInsets.only(left: 10),
                              height: 35,
                              child: FlatButton.icon(
                                  onPressed: () {
                                    subscribeAction();
                                  },
                                  icon: Icon(Icons.play_circle_filled,
                                      color: Colors.white),
                                  color: Colors.red,
                                  label: Text("Subscribe",
                                      style: TextStyle(
                                          color: subscribedVideo
                                              ? Colors.grey
                                              : Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          Container()
                        ],
                      ),
                    ],
                  ),
                ),

                //SizedBox(width:220, ),

                SizedBox(
                  height: 10,
                ),
                likes(),

                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Container(height: 1, width: 155, color: Colors.white10)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            backgroundImage:
                                FileImage(File(videoModel.video.writer.image)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(videoModel.video.writer.name,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Helvetica",
                                color: Color(0xFF909090))),
                      ],
                    ),
                    //SizedBox( width: 10,),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(height: 1, width: 155, color: Colors.white10)
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Text(videoModel.video.description,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Helvetica",
                            color: Color(0xFF909090))),

                    comments(),
                  ],
                ),
              ],
            ),
          ),
        ]),
      )
    ]);
  }

  var _subscribeModel = SubscribeModel();

  Future changeSubscribeNum() async {
    _subscribeModel = SubscribeModel(userTo: _userModel.id);
    var subNum = await _networkHandler.post('/api/subscribe/subscribeNumber',
        json.encode(_subscribeModel.toJson()));

    var res = json.decode(subNum.body);
    print(res);

    setState(() {
      _subscribeModel = SubscribeModel.fromJson(res);
      number = _subscribeModel.subscribeNumber;
    });

    print(_subscribeModel.subscribeNumber);

    //// subscribed
    if (isLoaded) {
      _subscribeModel = SubscribeModel(
          userTo: _userModel.id, userFrom: videoModel.video.writer.id);
      var subscribed = await _networkHandler.post(
          '/api/subscribe/subscribed', json.encode(_subscribeModel.toJson()));

      var sub = json.decode(subscribed.body);
      print(sub);

      setState(() {
        _subscribeModel = SubscribeModel.fromJson(sub);
        subscribedVideo = _subscribeModel.subscribed;

        //isLoaded = true;
      });
    }

    likesModel = LikesModel(videoId: videoModel.video.id);
    var likeNum = await _networkHandler.post(
        '/api/like/getLikes', json.encode(likesModel.toJson()));

    var like = json.decode(likeNum.body);
    print(res);

    setState(() {
      likesModel = LikesModel.fromJson(like);
      liked = likesModel.likes.length;
      isLoaded = true;
    });

    print('likes' + liked.toString());

    likesModel = LikesModel(videoId: videoModel.video.id);
    var unlikeNum = await _networkHandler.post(
        '/api/like/getDislikes', json.encode(likesModel.toJson()));

    var unlike = json.decode(unlikeNum.body);
    print(res);

    setState(() {
      likesModel = LikesModel.fromJson(unlike);
      disliked = likesModel.unlikes.length;
      isLoaded = true;
    });

    print('likes' + like.toString());
  }

  subscribeAction() async {
    if (subscribedVideo) {
      // unsubscribe
      _subscribeModel = SubscribeModel(
          userTo: _userModel.id, userFrom: videoModel.video.writer.id);
      var subscribe = await _networkHandler.post(
          '/api/subscribe/unsubscribe', json.encode(_subscribeModel.toJson()));
      var res = json.decode(subscribe.body);

      if (res['success']) {
        setState(() {
          _subscribeModel = SubscribeModel.fromJson(res);
          subscribedVideo = !subscribedVideo;
          number = number - 1;
        });
      } else {
        print("unable to subcribe");
      }

      print(res);
    } else {
      // unsubscribe
      _subscribeModel = SubscribeModel(
          userTo: _userModel.id, userFrom: videoModel.video.writer.id);
      var unsubscribe = await _networkHandler.post(
          '/api/subscribe/subscribe', json.encode(_subscribeModel.toJson()));
      var res = json.decode(unsubscribe.body);

      if (res['success']) {
        setState(() {
          _subscribeModel = SubscribeModel.fromJson(res);
          subscribedVideo = !subscribedVideo;
          number = number + 1;
        });
      }
    }
  }

  likeAction() async {
    if (liked != 0) {
      likesModel = LikesModel(videoId: videoModel.videoId, userId: _userModel.id);
      var like = await _networkHandler.post(
          '/api/like/unLike', json.encode(likesModel.toJson()));
      var res = json.decode(like.body);

      if (disliked == 0) {
        setState(() {
          disliked = disliked + 1;
          _liked = !_liked;
        });
      }

      if (res['success']) {
        setState(() {
          likesModel = LikesModel.fromJson(res);
          liked = liked - 1;
          _liked = !_liked;
        });
      }
    } else {
      likesModel =
          LikesModel(videoId: videoModel.videoId, userId: _userModel.id);
      var like = await _networkHandler.post(
          '/api/like/upLike', json.encode(likesModel.toJson()));
      var res = json.decode(like.body);

      if (res['success']) {
        setState(() {
          likesModel = LikesModel.fromJson(res);
          liked = liked + 1;
          _liked = !_liked;
        });
      }
    }
  }

  unlikeAction() async {
    if (disliked != 0) {
      likesModel = LikesModel(videoId: videoModel.videoId, userId: _userModel.id);
      var like = await _networkHandler.post(
          '/api/like/unDisLike', json.encode(likesModel.toJson()));
      var res = json.decode(like.body);

      if (liked == 0) {
        setState(() {
          liked = liked + 1;
          _disliked = !_disliked;
        });
      }

      if (res['success']) {
        setState(() {
          likesModel = LikesModel.fromJson(res);
          disliked = disliked - 1;
          _disliked = !_disliked;
        });
      }
    } else {
      likesModel = LikesModel(videoId: videoModel.videoId, userId: _userModel.id);
      var like = await _networkHandler.post(
          '/api/like/upDisLike', json.encode(likesModel.toJson()));
      var res = json.decode(like.body);

      if (res['success']) {
        setState(() {
          likesModel = LikesModel.fromJson(res);
          disliked = disliked + 1;
          _disliked = !_disliked;
        });
      }
    }
  }

  String getTimeSinceUpload(String uploadedDate) {
    DateTime date = DateTime.parse(uploadedDate);
    DateTime now = DateTime.now();
    int minutes = now.difference(date).inMinutes;

    int hours = now.difference(date).inHours;
    int days = now.difference(date).inDays;
    double weeks = days / 7;
    double months = weeks / 4;
    double years = days / 365;

    if (years >= 1) {
      String year = " year";
      if (years >= 2) {
        year = " years";
      }
      return years.toInt().toString() + year;
    } else if (months >= 1) {
      String month = " month";
      if (months >= 2) {
        month = " months";
      }
      return months.toInt().toString() + month;
    } else if (weeks >= 1) {
      String week = " week";
      if (weeks >= 2) {
        week = " weeks";
      }
      return weeks.toInt().toString() + week;
    } else if (days >= 1) {
      String day = " day";
      if (days >= 2) {
        day = " days";
      }
      return days.toInt().toString() + day;
    } else if (hours >= 1) {
      String hour = " hour";
      if (hours >= 2) {
        hour = " hours";
      }
      return hours.toInt().toString() + hour;
    } else if (minutes >= 1) {
      String minute = " minute";
      if (minutes >= 2) {
        minute = " minutes";
      }
      return minutes.toInt().toString() + minute;
    } else {
      return "not long";
    }
  }

  Widget likes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            InkWell(
              onTap: () async {
                likeAction();
              },
              child: Icon(Icons.thumb_up,
                  color: Colors.white.withOpacity(0.3), size: 15),
            ),
            Center(
                child: Text(liked.toString(),
                    style: TextStyle(
                        fontSize: 10, color: Colors.white.withOpacity(0.5)))),
          ],
        ),
        SizedBox(
          width: 10,
          height: 10,
        ),
        Column(
          children: [
            InkWell(
              onTap: () async {
                unlikeAction();
              },
              child: Icon(
                Icons.thumb_down,
                color: Colors.white.withOpacity(0.3),
                size: 15,
              ),
            ),
            Text(disliked.toString(),
                style: TextStyle(
                    fontSize: 10, color: Colors.white.withOpacity(0.5))),
          ],
        ),
        Center(
            child: SizedBox(
          width: 10,
        )),
        Text(" ∙ ",
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Helvetica",
                color: Color(0xFF909090))),
        Container(
            width: 100,
            child: Text(number.toString() + ' Subscriber(s)',
                style: TextStyle(
                    fontSize: 10, color: Colors.white.withOpacity(0.5)))),
      ],
    );
  }

  Widget comments() {
    return Text("comments");
  }
}
