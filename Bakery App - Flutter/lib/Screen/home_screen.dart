import 'package:bakey/Screen/product_detail_page.dart';
import 'package:bakey/model/product_model.dart';
import 'package:bakey/repository/product_repo.dart';
import 'package:flutter/material.dart';

import '../app/constant.dart';

class GridHomeScreen extends StatefulWidget {
  const GridHomeScreen({super.key});

  static const String route = "gridHomeScreen";

  @override
  State<GridHomeScreen> createState() => _GridHomeScreenState();
}

class _GridHomeScreenState extends State<GridHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home of all Bakery Items"),
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
                      return GridView.count(
                        // itemCount: snapshot.data!.length,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          for (var product in snapshot.data!)
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ProductDetailPage.route,
                                  arguments: product,
                                );
                              },
                              child: Card(
                                child: Image.network(
                                  Constant.productImageURL + product.image!,
                                  height: 350,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // child: ProductWidget(
                              //   product: snapshot.data![0],
                              // ),
                            )
                        ],
                      );
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
