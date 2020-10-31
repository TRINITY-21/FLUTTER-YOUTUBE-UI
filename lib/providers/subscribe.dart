import 'dart:convert';

import 'package:Youtube/api/network_handler.dart';
import 'package:Youtube/models/registrationModel.dart';
import 'package:Youtube/models/subscribeModel.dart';

class Subscribe {
  NetworkHandler _networkHandler = NetworkHandler();
  SubscribeModel _subscribeModel = SubscribeModel();
  RegistrationModel _userModel = RegistrationModel();

  int _subscribeNum;
  bool _subscribed;

  int get subscribeNum => _subscribeNum;
  bool get subscribed => _subscribed;

  /// get current user
  void getUser() async {
    final res = await _networkHandler.get('/api/users/auth');

    _userModel = RegistrationModel.fromJson(res);
    print(res);
    print('currUser ${_userModel.image}');
  }

  changeSubscribeNum(writerId, userId) async {
    
    _subscribeModel = SubscribeModel(userTo: userId);
    var res = await _networkHandler.post('/api/subscribe/subscribeNumber',
        json.encode(_subscribeModel.toJson()));
    _subscribeModel = SubscribeModel.fromJson(json.decode(res.body));
    _subscribeNum = _subscribeModel.subscribeNumber;

    print(_subscribeNum);

    //// subscribed
    _subscribeModel = SubscribeModel(userTo: userId, userFrom: writerId);
    var subscribed = await _networkHandler.post(
        '/api/subscribe/subscribed', json.encode(_subscribeModel.toJson()));

    _subscribeModel = SubscribeModel.fromJson(json.decode(subscribed.body));
    _subscribed = _subscribeModel.subscribed;

    if (_subscribed) {
      // subscribed
      _subscribeModel = SubscribeModel(userTo: userId, userFrom: writerId);
      var subscribe = await _networkHandler.post(
          '/api/subscribe/unSubscribe', json.encode(_subscribeModel.toJson()));
      var res = json.decode(subscribe.body);

      _subscribeModel = SubscribeModel.fromJson(res);
      if (res['success']) {
        _subscribed = !_subscribed;
        _subscribeNum = (_subscribeNum - 1);
      } else {
        print("unable to unsubcribe");
      }

    } else {
      // subscribed
      _subscribeModel = SubscribeModel(userTo: userId, userFrom: writerId);
      var subscribe = await _networkHandler.post(
          '/api/subscribe/subscribe', json.encode(_subscribeModel.toJson()));
      var res = json.decode(subscribe.body);

      _subscribeModel = SubscribeModel.fromJson(res);
      
      if (res['success']) {
        _subscribed = !_subscribed;
        _subscribeNum = (_subscribeNum + 1);
      } else {
        print("unable to subscribe");
      }

     
      print(subscribe.body);
    }
  }
}
