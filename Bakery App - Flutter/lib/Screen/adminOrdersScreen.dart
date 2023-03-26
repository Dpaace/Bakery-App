import 'package:bakey/Screen/updateOrderStatus.dart';
import 'package:flutter/material.dart';

import '../app/constant.dart';
import '../model/order_model.dart';
import '../repository/order_repo.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  static const String route = "adminOrdersScreen";

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Total Orders"),
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
                          IconButton(
                            onPressed: () async {
                              Navigator.pushNamed(
                                context,
                                UpdateOrderStatusScreen.route,
                                arguments: snapshot.data![index],
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          ElevatedButton(
                            onPressed: null,
                            child: Text(
                              snapshot.data![index].status!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
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
