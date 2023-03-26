import 'package:bakey/model/order_model.dart';
import 'package:bakey/repository/order_repo.dart';
import 'package:flutter/material.dart';

import '../app/constant.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({super.key});

  static const String route = "userOrdersScreen";

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
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
                    return ListTile(
                      title: Text(snapshot.data![index].products!.name!),
                      trailing: Wrap(
                        children: [
                          Image.network(
                            Constant.productImageURL +
                                snapshot.data![index].products!.image!,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          // IconButton(
                          //   onPressed: () async {},
                          //   icon: const Icon(Icons.delete),
                          // ),
                          ElevatedButton(
                            onPressed: () async {},
                            child: Text(snapshot.data![index].status!),
                          )
                        ],
                      ),
                    );
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
  }
}
