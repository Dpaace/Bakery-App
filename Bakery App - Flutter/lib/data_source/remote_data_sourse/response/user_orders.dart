import 'package:json_annotation/json_annotation.dart';

import '../../../model/user.dart';

part 'user_orders.g.dart';

@JsonSerializable()
class UserOrdersResponse {
  bool? success;
  String? message;
  User? data;

  UserOrdersResponse({this.success, this.message, this.data});

  factory UserOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrdersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserOrdersResponseToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs