import 'package:bakey/Screen/widgets/productCard.dart';
import 'package:bakey/model/product_model.dart';
import 'package:bakey/repository/product_repo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: ProductRepositoryImpl().getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // List<UserStatus>? data = snapshot.data;
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // final item = snapshot.data![index];
                  return ProductWidget(
                    product: snapshot.data![index],
                  );
                },
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
    );
  }
}
