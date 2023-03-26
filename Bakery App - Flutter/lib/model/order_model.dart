import 'package:bakey/model/product_model.dart';
import 'package:bakey/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'order_model.g.dart';

@Entity()
@JsonSerializable()
class Orders {
  @Id(assignable: true)
  int oid;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? orderId;

  String? status;

  final user = ToOne<User>;

  // @Backlink()
  final product = ToOne<Product>;

  @JsonKey(name: 'user')
  User? userr;

  @JsonKey(name: 'product')
  Product? products;

  Orders({
    this.oid = 0,
    this.orderId,
    this.userr,
    this.products,
    this.status,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs
