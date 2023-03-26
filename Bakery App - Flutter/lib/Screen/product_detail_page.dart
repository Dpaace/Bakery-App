import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bakey/app/constant.dart';
import 'package:bakey/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import '../repository/cart_repo.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});
  // final Product products;
  // const ProductDetailPage({required this.products, super.key});

  static const String route = "productDetailPage";

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Product product;

  @override
  void didChangeDependencies() {
    product = ModalRoute.of(context)!.settings.arguments as Product;
    super.didChangeDependencies();
  }

  _saveCart() async {
    int status = await CartRepositoryImpl().addCart(product.productID!);
    _showMessage(status);
  }

  _showMessage(int status) {
    if (status > 0) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: "Product Added To Cart",
          body: "New Bakery Item has been added to the cart",
        ),
      );

      MotionToast.success(
        description: const Text("Item Added to cart successfully"),
      ).show(context);
      // Navigator.pushNamed(context, LoginScreen.route);
    } else {
      MotionToast.error(
        description: const Text("Cart Addition Failed"),
      ).show(context);
    }
  }

  // Product product = Product(
  //   name: "Product",
  //   description: "haha",
  //   // image: 'image.png',
  //   price: 100,
  //   weight: "100g",
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Card(
        margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        shadowColor: Colors.white,
        elevation: 4.0,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
          child: Stack(
            children: [
              Column(
                children: [
                  product.image != null
                      ? Image.network(
                          Constant.productImageURL + product.image!,
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/2.jpg",
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // widget.product.name!,
                                  "Bakery Item Name: \n${product.name!}",
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    width: double.infinity,
                    color: const Color(0xff7A4069),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            // widget.product.description!,
                            "Item Description: \n${product.description!}",
                            style: const TextStyle(
                              color: Color(0xffD3756B),
                              fontWeight: FontWeight.normal,
                              fontSize: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 3,
                    width: double.infinity,
                    color: const Color(0xffF637EC),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            // widget.product.weight!,
                            "Item Weight: \n${product.weight!}",
                            style: const TextStyle(
                              color: Color(0xff94B49F),
                              fontWeight: FontWeight.normal,
                              fontSize: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 3,
                    width: double.infinity,
                    color: const Color(0xffD61C4E),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(160, 4, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            // widget.product.price!.toString(),
                            "Price: \n${product.price!.toString()}",
                            style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _saveCart();
        },
        label: const Text('Add To Cart'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
