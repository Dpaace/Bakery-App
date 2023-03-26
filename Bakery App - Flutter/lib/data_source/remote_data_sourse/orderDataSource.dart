import 'package:bakey/app/constant.dart';
import 'package:bakey/data_source/remote_data_sourse/response/orderResponse.dart';
import 'package:bakey/model/order_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/http_services.dart';

class OrderRemoteDataSourse {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addOrder(String productId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpServices.post(
        Constant.addOrder,
        queryParameters: {
          'id': productId,
        },
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            "Authorization": token,
          },
        ),
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<List<Orders>> getAllOrders() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpServices.get(
        Constant.order,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            "Authorization": token,
          },
        ),
      );
      List<Orders> lstOrders = [];
      if (response.statusCode == 200) {
        OrderResponse cartResponse = OrderResponse.fromJson(response.data);
        lstOrders = cartResponse.data!;
        return lstOrders;
      } else {
        return [];
      }
    } catch (e) {
      // return [];
      throw Exception(e.toString());
    }
  }

  Future<int> updateOrderStatus(String orderId, Orders orders) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpServices.put(
        Constant.updateOrderStatus,
        queryParameters: {
          'id': orderId,
        },
        data: {
          "status": orders.status,
        },
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
