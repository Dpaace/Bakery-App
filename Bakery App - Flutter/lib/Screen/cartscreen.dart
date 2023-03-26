import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bakey/model/cart_model.dart';
import 'package:bakey/repository/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/constant.dart';
import '../repository/cart_repo.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  static const String route = "cartscreen";

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  void initState() {
    getCredentials();
    super.initState();
  }

  String token = "";
  void getCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('token')!;
    });
  }

  _saveOrder(String productId) async {
    int status = await OrderRepositoryImpl().addOrder(productId);
    _showMessage(status);
  }

  _showMessage(int status) {
    if (status > 0) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: "Product Ordered",
          body: "New Bakery Item has been added to the cart",
        ),
      );
      MotionToast.success(
        description: const Text("Item Ordered successfully"),
      ).show(context);
      // Navigator.pushNamed(context, LoginScreen.route);
    } else {
      MotionToast.error(
        description: const Text("Order Failed"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cart Products"),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<Cart>>(
            future: CartRepositoryImpl().getAllCartProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // return ListView.builder(
                      //   itemCount: snapshot.data!.length,
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index) {
                      //     return ListTile(
                      //       title: Text(snapshot.data![index].products!.name!),
                      //       trailing: Wrap(
                      //         children: [
                      //           Image.network(
                      //             Constant.productImageURL +
                      //                 snapshot.data![index].products!.image!,
                      //             height: 50,
                      //             width: 50,
                      //           ),
                      //           IconButton(
                      //             onPressed: () async {
                      //               // int status = await ProductRepositoryImpl()
                      //               //     .deleteProduct(
                      //               //         snapshot.data![index].productID!);
                      //               // _showMessage(status);
                      //               int cartStatus = await CartRepositoryImpl()
                      //                   .deleteCartProduct(
                      //                       snapshot.data![index].cartID);
                      //               _showMessage(cartStatus);
                      //             },
                      //             icon: const Icon(Icons.delete),
                      //           ),
                      //           ElevatedButton(
                      //             onPressed: () async {},
                      //             child: const Text("Order"),
                      //           )
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // );

                      return DisplayCartProductWidget(
                        snapshot.data![index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No Cart Products Found"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }
            },
          ),
        ));
  }
}

class DisplayCartProductWidget extends StatelessWidget {
  final Cart product;

  const DisplayCartProductWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    showOrderMessage(int status) {
      if (status > 0) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: "Product Ordered",
            body: "New Bakery Item has been added to the cart",
          ),
        );
        MotionToast.success(
          description: const Text("Item Ordered successfully"),
        ).show(context);
        // Navigator.pushNamed(context, LoginScreen.route);
      } else {
        MotionToast.error(
          description: const Text("Order Failed"),
        ).show(context);
      }
    }

    showCartMessage(int status) {
      if (status > 0) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: "Product Ordered",
            body: "Item ordered",
          ),
        );
      } else {
        MotionToast.error(
          description: const Text("Order Failed"),
        );
      }
    }

    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              Constant.productImageURL + product.products!.image!,
              height: 200,
              // width: 200,
              width: double.infinity,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey.withOpacity(0.5),
              child: ListTile(
                title: Text(
                  product.products!.name!,
                  // product.cartID,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  product.products!.price!.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                trailing: Wrap(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        int orderStatus = await OrderRepositoryImpl()
                            .addOrder(product.products!.productID!);
                        showOrderMessage(orderStatus);

                        int cartStatus = await CartRepositoryImpl()
                            .deleteCartProduct(product.cartID);
                        showCartMessage(cartStatus);
                      },
                      child: const Text("Order"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
