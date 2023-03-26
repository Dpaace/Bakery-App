import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bakey/Screen/updateProduct.dart';
import 'package:bakey/model/product_model.dart';
import 'package:bakey/repository/product_repo.dart';
import 'package:flutter/material.dart';

import '../app/show_snackbar.dart';

class AllAdminProductsScreen extends StatefulWidget {
  const AllAdminProductsScreen({super.key});

  static const String route = "allAdminProductsScreen";

  @override
  State<AllAdminProductsScreen> createState() => _AllAdminProductsScreenState();
}

class _AllAdminProductsScreenState extends State<AllAdminProductsScreen> {
  _showMessage(int status) {
    if (status > 0) {
      showSnackbar(context, 'Successfully Deleted Product', Colors.green);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: "Product Deleted",
          body: "Your Product is deleted",
        ),
      );
      // Navigator.pop(context);
    } else {
      showSnackbar(context, 'Error in Deleting Product', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Total Products"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // const Text("List Of Different Bakery Items"),
              FutureBuilder<List<Product>>(
                future: ProductRepositoryImpl().getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name!),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProductUpdateScreen.route,
                                      arguments: snapshot.data![index],
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    int status = await ProductRepositoryImpl()
                                        .deleteProduct(
                                            snapshot.data![index].productID!);
                                    _showMessage(status);
                                    // setState(() {
                                    //   snapshot.data!.removeAt(index);
                                    // });
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      // return GridView.count(
                      //   // itemCount: snapshot.data!.length,
                      //   crossAxisCount: 2,
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   children: [
                      //     for (var product in snapshot.data!)
                      //       InkWell(
                      //         onTap: () {
                      //           Navigator.pushNamed(
                      //             context,
                      //             AdminProductDetailScreen.route,
                      //             arguments: product,
                      //           );
                      //         },
                      //         child: Card(
                      //           child: product.image == null
                      //               ? const Center(child: Text("No Image"))
                      //               : Image.network(
                      //                   Constant.productImageURL +
                      //                       product.image!,
                      //                   height: 100,
                      //                   width: double.infinity,
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //         ),
                      //       )
                      //   ],
                      // );
                    } else {
                      return const Center(
                        child: Text("No Products Found"),
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
            ],
          ),
        ),
      ),
    );
  }
}
