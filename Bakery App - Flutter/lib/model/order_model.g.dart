// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      oid: json['oid'] as int? ?? 0,
      orderId: json['_id'] as String?,
      userr: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      products: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'oid': instance.oid,
      '_id': instance.orderId,
      'status': instance.status,
      'user': instance.userr,
      'product': instance.products,
    };
