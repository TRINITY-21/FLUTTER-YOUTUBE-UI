import 'package:json_annotation/json_annotation.dart';

part 'loginModel.g.dart';

@JsonSerializable()

class LoginModel {
  String email;
  String password;

  LoginModel({this.email, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
