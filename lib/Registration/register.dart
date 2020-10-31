import 'dart:convert';
import 'dart:io';


import 'package:Youtube/Registration/login.dart';
import 'package:Youtube/api/network_handler.dart';
import 'package:Youtube/models/registrationModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  NetworkHandler _networkHandler = NetworkHandler();
  RegistrationModel _registerModel = RegistrationModel();
  PickedFile pickedFile;

  /// register
  sendAction() async {
    _registerModel = RegistrationModel(
        name: _name.text,
        email: _email.text,
        password: _password.text,
        image: pickedFile.path);

    final res = _networkHandler.post(
        '/api/users/register', json.encode(_registerModel.toJson()));

    if (pickedFile.path != null) {
      var imageResponse = await _networkHandler.patchImage(
          "/api/users/upload", pickedFile.path);

      print('image response $imageResponse');
    }

    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            emailTextField(),
            SizedBox(
              height: 20,
            ),
            passwordTextField(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                sendAction();

                if (_globalkey.currentState.validate()) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                }
              },
              child: Center(
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFD10303),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage:  pickedFile == null ? AssetImage("assets/img.webp") 
          : FileImage(File(pickedFile.path)),

          backgroundColor: Colors.white
        ),
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
              Icons.camera_alt,
              color: Color(0xFFD10303),
              size: 28.0,
            ),
          ),
        ),
      ]),
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
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _name,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFFFFFFFF),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Color(0xFFD10303),
        ),
        labelText: "Name",
        helperText: "Name can't be empty",
        helperStyle: TextStyle(color: Colors.white),
        hintText: "Username",
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _email,
      validator: (value) {
        if (value.isEmpty) return "Email can't be empty";

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
          Icons.email,
          color: Color(0xFFD10303),
        ),
        labelText: "Email",
        helperText: "Email can't be empty",
        helperStyle: TextStyle(color: Colors.white),
        hintText: "example@example.com",
      ),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.white),
      controller: _password,
      validator: (value) {
        if (value.isEmpty) return "Password can't be empty";

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
          Icons.lock,
          color: Color(0xFFD10303),
        ),
        labelText: "Password",
        helperText: "Password can't be empty",
        helperStyle: TextStyle(color: Colors.white),
        hintText: "Password",
      ),
    );
  }

  void pickImage(ImageSource source) async {
    final image = await ImagePicker().getImage(source: source);

    setState(() {
      pickedFile = image;
    });
  }
}
