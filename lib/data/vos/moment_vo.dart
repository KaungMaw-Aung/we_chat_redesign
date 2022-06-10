import 'package:json_annotation/json_annotation.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
class MomentVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "username")
  String? username;

  @JsonKey(name: "post_media")
  String? postMedia;

  MomentVO({
    this.id,
    this.description,
    this.profilePicture,
    this.username,
    this.postMedia,
  });

  factory MomentVO.fromJson(Map<String, dynamic> json) => _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);

}
