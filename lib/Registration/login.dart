import 'dart:convert';

import 'package:Youtube/api/network_handler.dart';
import 'package:Youtube/models/loginModel.dart';
import 'package:Youtube/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  NetworkHandler _networkHandler = NetworkHandler();
  LoginModel _loginModel = LoginModel();
  FlutterSecureStorage _storage = FlutterSecureStorage();

  void sendAction() async {
    _loginModel = LoginModel(email: _email.text, password: _password.text);
    final res = await _networkHandler.post(
        '/api/users/login', json.encode(_loginModel.toJson()));

    Map<String, dynamic> output = json.decode(res.body);
    if (output['loginSuccess']) {
      await _storage.write(key: "token", value: output['user']['token']);
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          children: <Widget>[
            Image(
              image: AssetImage('assets/logo.png'),
              height: 150,
            ),
            Center(
              child: Text(
                "Login",
                style: TextStyle(fontSize: 25),
              ),
            ),
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

                setState(() {});

                if (_globalkey.currentState.validate()) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
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
                      "Login",
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
}
