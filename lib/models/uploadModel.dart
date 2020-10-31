import 'package:json_annotation/json_annotation.dart';

part 'uploadModel.g.dart';

@JsonSerializable()
class UploadModel {
  String filePath;
  String fileName;
  double fileDuration;
  String thumbnail;
  String title;
  String description;
  String writer;
  String thumbsFilePath;
  String views;
  double duration;


  UploadModel(
      {this.fileName,
      this.title,
      this.writer,
      this.filePath,
      this.duration,
      this.views,
      this.description,
      this.fileDuration,
      this.thumbnail,
      this.thumbsFilePath});

  factory UploadModel.fromJson(Map<String, dynamic> json) =>
      _$UploadModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadModelToJson(this);
}
