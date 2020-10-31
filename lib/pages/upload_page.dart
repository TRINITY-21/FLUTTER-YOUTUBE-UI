import 'dart:convert';
import 'dart:io';

import 'package:Youtube/api/network_handler.dart';
import 'package:Youtube/models/registrationModel.dart';
import 'package:Youtube/models/uploadModel.dart';
import 'package:Youtube/pages/home_page.dart';
import 'package:Youtube/tabs/home_tab.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

///import "package:path/path.dart";

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  NetworkHandler _networkHandler = NetworkHandler();
  UploadModel _upload = UploadModel();

  File videoFile;
  String filePath;
  String fileName;

  Future uploadVideo() async {
    if (videoFile.path != null) {
      var imageResponse = await _networkHandler.patchImage(
          "/api/video/uploadfiles", videoFile.path);

      await http.Response.fromStream(imageResponse).then((response) async {
        if (response.statusCode == 200) {
          print("response body " + response.body);
          final res = json.decode(response.body);
          print("res is ${res['filePath']}");
          setState(() {
            filePath = res['filePath'];
            fileName = res['fileName'];
          });

          print(filePath);
          print(fileName);
        }

        return response.body;
      });

      print(filePath);
      print(fileName);
    }

    _upload = UploadModel(fileName: fileName, filePath: filePath);
    var thumb = await _networkHandler.post(
        "/api/video/thumbnail", json.encode(_upload.toJson()));

    setState(() {
      _upload = UploadModel.fromJson(json.decode(thumb.body));
    });

    print("Uploding...$_upload");
    print(_upload.fileDuration.toString());
    print(_upload.thumbsFilePath.toString());
    print(_upload.fileName.toString());
  }

  // get current user;
  RegistrationModel _userModel = RegistrationModel();

  /// get current user
  void getUser() async {
    final res = await _networkHandler.get('/api/users/auth');
    setState(() {
      _userModel = RegistrationModel.fromJson(res);
    });

    print(res);
    print('currUser $_userModel');
    print(_userModel.id);
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  ///  save all info
  void uploadData() async {
    _upload = UploadModel(
        description: _description.text,
        duration: _upload.fileDuration,
        title: _title.text,
        filePath: videoFile.path,
        thumbnail: _upload.thumbsFilePath,
        views: '0',
        writer: _userModel.id);

    // print(_upload.description);
    // print(_upload.duration);
    // print(_upload.title);
    // print(_upload.filePath);
    // print(_upload.thumbnail);
    // print(_upload.views);
    // print(_upload.writer);

    await _networkHandler.post(
        '/api/video/uploadVideo', json.encode(_upload.toJson()));

    print(_upload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF212121),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              height: 500,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: imageProfile(),
                    ),
                    SizedBox(height: 10),
                    titleTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    descriptionTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 15),
                    FlatButton.icon(
                        color: Colors.red,
                        onPressed: () {
                          uploadData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        icon: Icon(Icons.file_upload, color: Colors.white),
                        label: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ))
                  ]),
            ),
          ),
        ));
  }

  Widget titleTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _title,
      validator: (value) {
        if (value.isEmpty) return "Title can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.title,
          color: Color(0xFFD10303),
        ),
        labelText: "Title",
        helperText: "Title can't be empty",
        helperStyle: TextStyle(color: Colors.white),
        hintText: "Flutter tutorials",
      ),
    );
  }

  Widget descriptionTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _description,
      validator: (value) {
        if (value.isEmpty) return "description can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.description,
          color: Color(0xFFD10303),
        ),
        labelText: "description",
        helperText: "description can't be empty",
        helperStyle: TextStyle(color: Colors.white),
        hintText: "description",
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Video",
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // FlatButton.icon(
            //   icon: Icon(Icons.camera),
            //   onPressed: () {
            //     pickImage(ImageSource.camera);
            //     Navigator.pop(context);
            //   },
            //   label: Text("Camera"),
            // ),
            FlatButton.icon(
              icon: Icon(Icons.image, color: Colors.red),
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: Text(
                "Gallery",
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              ),
            ),
          ])
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * (30 / 100),
            width: MediaQuery.of(context).size.width * (100 / 100),
            color: Colors.red,
            child: videoFile == null
                ? Center(
                    child: InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: Text("Upload Video here",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))),
                  )
                : FittedBox(
                    fit: BoxFit.cover,
                    child: _upload.thumbsFilePath != null
                        ? Image(
                            image: _networkHandler
                                .getImage(_upload.thumbsFilePath),
                            fit: BoxFit.fill,
                          )
                        : Center(
                            heightFactor: 10,
                            widthFactor: 10,
                            child: CircularProgressIndicator(),
                          ),
                  )),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.file_upload,
              color: Color(0xFFFFFFFF),
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  // Widget videoPlayer() {
  //   return Container(
  //       color: Colors.brown,
  //       height: MediaQuery.of(context).size.height * (30 / 100),
  //       width: MediaQuery.of(context).size.width * (100 / 100),
  //       child: videoFile == null
  //           ? Center(
  //               child: InkWell(
  //                 onTap: () async {
  //                   showModalBottomSheet(
  //                     context: context,
  //                     builder: ((builder) => bottomSheet()),
  //                   );
  //                 },
  //                 child: Icon(
  //                   Icons.videocam,
  //                   color: Colors.red,
  //                   size: 50,
  //                 ),
  //               ),
  //             )
  //           : FittedBox(
  //               fit: BoxFit.contain,
  //               child: mounted
  //                   ? Chewie(
  //                       controller: ChewieController(
  //                       videoPlayerController:
  //                           VideoPlayerController.file(File(videoFile.path)),
  //                       aspectRatio: 3 / 2,
  //                       autoPlay: false,
  //                       looping: false,
  //                     ))
  //                   : Container(),
  //             ));
  // }

  void pickImage(ImageSource source) async {
    final theVid = await ImagePicker().getVideo(source: source);

    //if (videoFile != null) {
    setState(() {
      videoFile = File(theVid.path);
      print(('upload file ' + videoFile.path.split('/').last));
      print(videoFile.path);
    });
    await uploadVideo();

    //}
  }
}
