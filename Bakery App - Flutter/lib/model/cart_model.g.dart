// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      cid: json['cid'] as int? ?? 0,
      cartID: json['_id'] as String,
      userr: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      products: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'cid': instance.cid,
      '_id': instance.cartID,
      'user': instance.userr,
      'product': instance.products,
    };
