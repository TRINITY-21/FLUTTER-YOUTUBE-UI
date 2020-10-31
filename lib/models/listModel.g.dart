// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListModel _$ListModelFromJson(Map<String, dynamic> json) {
  return ListModel(
    title: json['title'] as String,
    writer: json['writer'] == null
        ? null
        : RegistrationModel.fromJson(json['writer'] as Map<String, dynamic>),
    filePath: json['filePath'] as String,
    duration: json['duration'] as String,
    createdAt: json['createdAt'] as String,
    views: json['views'] as int,
    description: json['description'] as String,
    thumbnail: json['thumbnail'] as String,
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$ListModelToJson(ListModel instance) => <String, dynamic>{
      '_id': instance.id,
      'filePath': instance.filePath,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'description': instance.description,
      'writer': instance.writer,
      'views': instance.views,
      'duration': instance.duration,
      'createdAt': instance.createdAt,
    };
