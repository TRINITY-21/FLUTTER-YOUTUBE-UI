// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikesModel _$LikesModelFromJson(Map<String, dynamic> json) {
  return LikesModel(
    videoId: json['videoId'] as String,
    commentId: json['commentId'] as String,
    id: json['id'] as String,
    likes:json['likes'] as List,
    unlikes:json['unlikes'] as List,
    userId:json['userId'] as String
  );
}

Map<String, dynamic> _$LikesModelToJson(LikesModel instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'commentId': instance.commentId,
      'id': instance.id,
      'likes':instance.likes,
      'unlikes':instance.unlikes,
      'userId':instance.userId
    };
