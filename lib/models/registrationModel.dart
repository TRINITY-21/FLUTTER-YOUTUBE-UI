import 'package:json_annotation/json_annotation.dart';

part 'registrationModel.g.dart';

@JsonSerializable()
class RegistrationModel {
  String name;
  String email;
  String password;
  String image;
  @JsonKey(name: '_id')
  String id;
  String token;

  RegistrationModel(
      {this.id,this.token,this.email, this.name, this.password, this.image});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationModelToJson(this);
}
