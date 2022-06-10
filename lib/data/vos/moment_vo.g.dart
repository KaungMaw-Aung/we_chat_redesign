// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map<String, dynamic> json) => MomentVO(
      id: json['id'] as String?,
      description: json['description'] as String?,
      profilePicture: json['profile_picture'] as String?,
      username: json['username'] as String?,
      postMedia: json['post_media'] as String?,
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'profile_picture': instance.profilePicture,
      'username': instance.username,
      'post_media': instance.postMedia,
    };
