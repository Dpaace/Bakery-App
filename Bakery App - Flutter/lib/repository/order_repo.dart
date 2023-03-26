import 'package:bakey/data_source/remote_data_sourse/orderDataSource.dart';
import 'package:bakey/model/order_model.dart';

abstract class OrderRepository {
  Future<List<Orders>> getAllOrders();
  Future<int> addOrder(String productId);

  Future<int> updateOrderStatus(String orderId, Orders orders);
}

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<List<Orders>> getAllOrders() {
    return OrderRemoteDataSourse().getAllOrders();
  }

  @override
  Future<int> addOrder(String productId) {
    return OrderRemoteDataSourse().addOrder(productId);
  }

  @override
  Future<int> updateOrderStatus(String orderId, Orders orders) {
    return OrderRemoteDataSourse().updateOrderStatus(orderId, orders);
  }
}
