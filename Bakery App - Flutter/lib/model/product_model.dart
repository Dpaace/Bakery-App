import 'package:bakey/model/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'product_model.g.dart';

@Entity()
@JsonSerializable()
class Product {
  @Id(assignable: true)
  int pid;

  @Unique()
  @JsonKey(name: '_id')
  String? productID;

  final double? price;
  final String? name;
  final String? description;
  final String? image;
  final String? weight;

  final cart = ToMany<Cart>;

  Product({
    this.productID,
    this.price,
    this.name,
    this.description,
    this.image,
    this.weight,
    this.pid = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs

const groceryProducts = <Product>[
  // GroceryProduct(
  //   price: 8.30,
  //   name: "Vanilla",
  //   descripcion:
  //       "The avacado is a fleshy exotic fruit obtained from the tropical",
  //   image: "assets/images/2.jpg",
  //   weight: '500g',
  // ),
  // GroceryProduct(
  //   price: 11.00,
  //   name: "Strawberry",
  //   descripcion:
  //       "It is good fruit for everyone except diabetics and obese because of its heih starch and more",
  //   image: "assets/images/3.jpg",
  //   weight: '1000g',
  // ),
  // GroceryProduct(
  //   price: 15.0,
  //   name: "Chocolate",
  //   descripcion:
  //       "The Mango is a fleshy exotic fruit obtained from the tropical",
  //   image: "assets/images/4.jpg",
  //   weight: '800g',
  // ),
];
