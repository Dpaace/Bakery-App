import 'package:bakey/model/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cartResponse.g.dart';

@JsonSerializable()
class CartResponse {
  bool? success;
  String? message;
  List<Cart>? data;

  CartResponse({this.success, this.message, this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}
// flutter pub run build_runner build --delete-conflicting-outputs