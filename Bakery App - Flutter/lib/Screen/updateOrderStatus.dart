import 'package:bakey/model/order_model.dart';
import 'package:bakey/repository/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class UpdateOrderStatusScreen extends StatefulWidget {
  const UpdateOrderStatusScreen({super.key});

  static const String route = "updateOrderStatusScreen";

  @override
  State<UpdateOrderStatusScreen> createState() =>
      _UpdateOrderStatusScreenState();
}

class _UpdateOrderStatusScreenState extends State<UpdateOrderStatusScreen> {
  late Orders orders;

  @override
  void didChangeDependencies() {
    orders = ModalRoute.of(context)!.settings.arguments as Orders;
    super.didChangeDependencies();
  }

  final _key = GlobalKey<FormState>();
  final _statusController = TextEditingController(text: 'Order Completed');

  _updateProduct(String orderId) async {
    Orders orders = Orders(
      status: _statusController.text,
    );
    int status = await OrderRepositoryImpl().updateOrderStatus(orderId, orders);
    _showMessage(status);
  }

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text("Order Status Updated successfully"),
      ).show(context);
      // Navigator.pushNamed(context, AdminOrdersScreen.route);
    } else {
      MotionToast.error(
        description: const Text("Order Status Update Failed"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Order Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // "Produt Name: ${product.name}",
                orders.status!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans Italic",
                ),
              ),
              TextFormField(
                controller: _statusController,
                // initialValue: product.name!,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter order status';
                  }
                  return null;
                }),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _updateProduct(orders.orderId!);
                  },
                  child: const Text("Update"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
