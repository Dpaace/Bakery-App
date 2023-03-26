import 'package:bakey/model/cart_model.dart';
import 'package:bakey/model/order_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.g.dart';

@Entity()
@JsonSerializable()
class User {
  @Id(assignable: true)
  int id;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? userId;

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? password;
  String? role;

  final cart = ToOne<Cart>;

  @Backlink()
  final orders = ToMany<Orders>;

  // @JsonKey(name: 'orders')
  // List<Orders>? order;

  User({
    this.id = 0,
    this.userId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.role,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs