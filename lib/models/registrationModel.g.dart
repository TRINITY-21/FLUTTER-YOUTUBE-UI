// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationModel _$RegistrationModelFromJson(Map<String, dynamic> json) {
  return RegistrationModel(
    id: json['_id'] as String,
    token: json['token'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    password: json['password'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$RegistrationModelToJson(RegistrationModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      '_id': instance.id,
      'token': instance.token,
    };
