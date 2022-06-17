// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePicture: json['profile_picture'] as String?,
      password: json['password'] as String?,
      qrCode: json['qr_code'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'profile_picture': instance.profilePicture,
      'password': instance.password,
      'qr_code': instance.qrCode,
      'fcm_token': instance.fcmToken,
    };
