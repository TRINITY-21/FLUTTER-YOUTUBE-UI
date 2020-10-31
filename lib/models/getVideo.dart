import 'package:Youtube/models/listModel.dart';
import 'package:Youtube/models/registrationModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'getVideo.g.dart';

@JsonSerializable()
class GetVideoModel {
  String videoId;
  ListModel video;

  GetVideoModel({this.videoId, this.video});

  factory GetVideoModel.fromJson(Map<String, dynamic> json) =>
      _$GetVideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetVideoModelToJson(this);
}
