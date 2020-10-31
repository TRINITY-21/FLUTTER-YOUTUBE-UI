// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getVideo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVideoModel _$GetVideoModelFromJson(Map<String, dynamic> json) {
  return GetVideoModel(
    videoId: json['videoId'] as String,
    video: json['video'] == null
        ? null
        : ListModel.fromJson(json['video'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetVideoModelToJson(GetVideoModel instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'video': instance.video,
    };
