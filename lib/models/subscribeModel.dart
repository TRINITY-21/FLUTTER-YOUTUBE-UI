import 'package:json_annotation/json_annotation.dart';

part 'subscribeModel.g.dart';

@JsonSerializable()
class SubscribeModel {
  @JsonKey(name: '_id')
  String id;
  String userTo;
  String userFrom;
  int subscribeNumber;
  bool subscribed;

  SubscribeModel(
      {this.id,
      this.subscribed,
      this.subscribeNumber,
      this.userFrom,
      this.userTo});

  factory SubscribeModel.fromJson(Map<String, dynamic> json) =>
      _$SubscribeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscribeModelToJson(this);
}
