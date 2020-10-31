import 'package:json_annotation/json_annotation.dart';

part 'likesModel.g.dart';

@JsonSerializable()
class LikesModel {
  String videoId;
  String commentId;
  String userId;
  String id;
  @JsonKey(name: '_id')
  List likes;
  List unlikes;

  LikesModel({this.videoId, this.userId,this.unlikes, this.commentId, this.id, this.likes});

  factory LikesModel.fromJson(Map<String, dynamic> json) =>
      _$LikesModelFromJson(json);

  Map<String, dynamic> toJson() => _$LikesModelToJson(this);
}
