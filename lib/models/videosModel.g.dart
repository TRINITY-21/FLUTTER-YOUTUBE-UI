// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videosModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideosModel _$VideosModelFromJson(Map<String, dynamic> json) {
  return VideosModel(
    videos: (json['videos'] as List)
        ?.map((e) =>
            e == null ? null : ListModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VideosModelToJson(VideosModel instance) =>
    <String, dynamic>{
      'videos': instance.videos,
    };
