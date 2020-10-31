import 'package:Youtube/pages/home_page.dart';
import 'package:Youtube/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  //bool isLoggedIn = false;

  FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final isAuth = _storage.read(key: "token");
    print("isAuth $isAuth");

    if (isAuth != null) {
      return HomePage();
    } else {
      return WelcomePage();
    }
  }
}
