// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribeModel _$SubscribeModelFromJson(Map<String, dynamic> json) {
  return SubscribeModel(
    id: json['_id'] as String,
    subscribed: json['subscribed'] as bool,
    subscribeNumber: json['subscribeNumber'] as int,
    userFrom: json['userFrom'] as String,
    userTo: json['userTo'] as String,
  );
}

Map<String, dynamic> _$SubscribeModelToJson(SubscribeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userTo': instance.userTo,
      'userFrom': instance.userFrom,
      'subscribeNumber': instance.subscribeNumber,
      'subscribed': instance.subscribed,
    };
