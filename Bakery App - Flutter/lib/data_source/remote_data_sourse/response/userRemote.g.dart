// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userRemote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRemote _$UserRemoteFromJson(Map<String, dynamic> json) => UserRemote(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserRemoteToJson(UserRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
