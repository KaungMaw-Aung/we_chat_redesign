import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "qr_code")
  String? qrCode;

  @JsonKey(name: "fcm_token")
  String? fcmToken;

  UserVO({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.password,
    this.qrCode,
    this.fcmToken,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String toString() {
    return 'UserVO{id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture, password: $password, qrCode: $qrCode, fcmToken: $fcmToken}';
  }
}
