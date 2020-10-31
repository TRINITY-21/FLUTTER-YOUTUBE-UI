
import 'package:flutter/material.dart';

class VideoWidget extends StatefulWidget {
  


  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/0.jpg"),
                      fit: BoxFit.fill,
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
                            backgroundImage: AssetImage("assets/0.jpg"),
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
                          Text("Video Titel",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Helvetica",
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.normal)),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text("Name",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Helvetica",
                                        color: Color(0xFF909090))),
                                Text(" ∙ ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Helvetica",
                                        color: Color(0xFF909090))),
                                Text(20.toString() + " views",
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
                                  "widget.video.getTimeSinceUpload()" + " ago",
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
        });
  }
}
