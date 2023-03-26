import 'package:bakey/model/order_model.dart';
import 'package:bakey/repository/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

import '../../app/constant.dart';

class WearOrdersScreen extends StatefulWidget {
  const WearOrdersScreen({super.key});

  static const String route = "wearOrdersScreen";

  @override
  State<WearOrdersScreen> createState() => _WearOrdersScreenState();
}

class _WearOrdersScreenState extends State<WearOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              // appBar: AppBar(
              //     // title: const Text("Your Orders"),
              //     ),
              body: SingleChildScrollView(
                child: FutureBuilder<List<Orders>>(
                  future: OrderRepositoryImpl().getAllOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DisplayOrdersWidget(
                              snapshot.data![index],
                            );
                            // return ListTile(
                            //   title:
                            //       Text(snapshot.data![index].products!.name!),
                            //   trailing: Wrap(
                            //     children: [
                            //       Image.network(
                            //         Constant.productImageURL +
                            //             snapshot.data![index].products!.image!,
                            //         height: 50,
                            //         width: 50,
                            //       ),
                            //       ElevatedButton(
                            //         onPressed: () async {},
                            //         child: Text(
                            //           snapshot.data![index].status!,
                            //           style: const TextStyle(),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No Orders Found"),
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
              ),
            );
          },
        );
      },
    );
  }
}

class DisplayOrdersWidget extends StatelessWidget {
  final Orders orders;

  const DisplayOrdersWidget(this.orders, {super.key});

  @override
  Widget build(BuildContext context) {
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
              Constant.productImageURL + orders.products!.image!,
              height: 80,
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
                  orders.products!.name!,
                  // orders.cartID,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  orders.status!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                // trailing: Wrap(
                //   children: [
                //     ElevatedButton(
                //       onPressed: () async {
                //         int orderStatus = await OrderRepositoryImpl()
                //             .addOrder(product.products!.productID!);
                //         showOrderMessage(orderStatus);

                //         int cartStatus = await CartRepositoryImpl()
                //             .deleteCartProduct(product.cartID);
                //         showCartMessage(cartStatus);
                //       },
                //       child: const Text("Order"),
                //     )
                //   ],
                // ),
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
