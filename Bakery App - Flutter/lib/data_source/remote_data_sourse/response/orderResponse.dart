import 'package:bakey/model/order_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderResponse.g.dart';

@JsonSerializable()
class OrderResponse {
  bool? success;
  String? message;
  List<Orders>? data;

  OrderResponse({this.success, this.message, this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
// flutter pub run build_runner build --delete-conflicting-outputs