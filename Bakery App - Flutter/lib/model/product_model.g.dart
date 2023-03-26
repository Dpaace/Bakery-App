// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productID: json['_id'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      weight: json['weight'] as String?,
      pid: json['pid'] as int? ?? 0,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'pid': instance.pid,
      '_id': instance.productID,
      'price': instance.price,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'weight': instance.weight,
    };
