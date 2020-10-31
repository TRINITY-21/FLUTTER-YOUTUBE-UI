import 'package:Youtube/models/listModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'videosModel.g.dart';

@JsonSerializable()
class VideosModel {
  List<ListModel> videos;

  VideosModel(
      {this.videos});

  factory VideosModel.fromJson(Map<String, dynamic> json) =>
      _$VideosModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideosModelToJson(this);
}
