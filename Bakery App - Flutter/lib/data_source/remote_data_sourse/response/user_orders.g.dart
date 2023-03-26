// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrdersResponse _$UserOrdersResponseFromJson(Map<String, dynamic> json) =>
    UserOrdersResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserOrdersResponseToJson(UserOrdersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
