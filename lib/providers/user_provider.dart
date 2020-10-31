import 'package:Youtube/api/network_handler.dart';
//import 'package:Youtube/models/registrationModel.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  //RegistrationModel _userModel = RegistrationModel();
  NetworkHandler _networkHandler = NetworkHandler();

  /// get current user
  Future getUser() async {
   // final res = await _networkHandler.get('/api/users/auth');

    //_userModel = RegistrationModel.fromJson(res);
    notifyListeners();
   
  }
}
