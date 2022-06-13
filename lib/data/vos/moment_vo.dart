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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MomentVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          profilePicture == other.profilePicture &&
          username == other.username &&
          postMedia == other.postMedia;

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      profilePicture.hashCode ^
      username.hashCode ^
      postMedia.hashCode;
}
