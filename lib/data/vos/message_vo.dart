import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO {
  @JsonKey(name: "user_id")
  String? userId;

  @JsonKey(name: "file")
  String? mediaUrl;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "name")
  String? username;

  @JsonKey(name: "profile_pic")
  String? profileUrl;

  @JsonKey(name: "timeStamp")
  int? sentAt;

  MessageVO(
    this.userId,
    this.mediaUrl,
    this.message,
    this.username,
    this.profileUrl,
    this.sentAt,
  );

  factory MessageVO.fromJson(Map<String, dynamic> json) => _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);

}
