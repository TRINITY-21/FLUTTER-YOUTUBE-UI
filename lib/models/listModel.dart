import 'package:Youtube/models/registrationModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listModel.g.dart';

@JsonSerializable()
class ListModel {
  @JsonKey(name: '_id')
  String id;
  String filePath;
  String thumbnail;
  String title;
  String description;
  RegistrationModel writer;
  int views;
  String duration;
  String createdAt;

  ListModel(
      {
      this.title,
      this.writer,
      this.filePath,
      this.duration,
      this.createdAt,
      this.views,
      this.description,
      this.thumbnail,
      this.id,
      });

  factory ListModel.fromJson(Map<String, dynamic> json) =>
      _$ListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListModelToJson(this);
}
