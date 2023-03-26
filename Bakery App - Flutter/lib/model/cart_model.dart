import 'package:bakey/model/product_model.dart';
import 'package:bakey/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'cart_model.g.dart';

@Entity()
@JsonSerializable()
class Cart {
  @Id(assignable: true)
  int cid;

  @Unique()
  @JsonKey(name: '_id')
  String cartID;

  // @Backlink()
  final user = ToOne<User>;

  @Backlink()
  final product = ToMany<Product>;

  @JsonKey(name: 'user')
  User? userr;

  @JsonKey(name: 'product')
  Product? products;

  Cart({
    this.cid = 0,
    required this.cartID,
    this.userr,
    this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs
