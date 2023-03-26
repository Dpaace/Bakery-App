import 'package:json_annotation/json_annotation.dart';

import '../../../model/user.dart';

part 'userRemote.g.dart';

@JsonSerializable()
class UserRemote {
  String? status;
  List<User>? data;

  UserRemote({this.status, this.data});

  factory UserRemote.fromJson(Map<String, dynamic> json) =>
      _$UserRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$UserRemoteToJson(this);
}
