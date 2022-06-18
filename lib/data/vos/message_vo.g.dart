// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      json['user_id'] as String?,
      json['file'] as String?,
      json['message'] as String?,
      json['name'] as String?,
      json['profile_pic'] as String?,
      json['timeStamp'] as int?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'user_id': instance.userId,
      'file': instance.mediaUrl,
      'message': instance.message,
      'name': instance.username,
      'profile_pic': instance.profileUrl,
      'timeStamp': instance.sentAt,
    };
