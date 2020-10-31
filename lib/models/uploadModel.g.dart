// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploadModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadModel _$UploadModelFromJson(Map<String, dynamic> json) {
  return UploadModel(
    fileName: json['fileName'] as String,
    title: json['title'] as String,
    writer: json['writer'] as String,
    filePath: json['filePath'] as String,
    duration: (json['duration'] as num)?.toDouble(),
    views: json['views'] as String,
    description: json['description'] as String,
    fileDuration: (json['fileDuration'] as num)?.toDouble(),
    thumbnail: json['thumbnail'] as String,
    thumbsFilePath: json['thumbsFilePath'] as String,
  );
}

Map<String, dynamic> _$UploadModelToJson(UploadModel instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'fileName': instance.fileName,
      'fileDuration': instance.fileDuration,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'description': instance.description,
      'writer': instance.writer,
      'thumbsFilePath': instance.thumbsFilePath,
      'views': instance.views,
      'duration': instance.duration,
    };
