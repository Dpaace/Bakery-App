import 'package:bakey/app/constant.dart';
import 'package:bakey/data_source/remote_data_sourse/response/cartResponse.dart';
import 'package:bakey/model/cart_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/http_services.dart';

class CartRemoteDataSourse {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addCartProduct(String productId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpServices.post(
        Constant.addCartProduct,
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

  Future<int> deleteCartProduct(String cartId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpServices.delete(
        Constant.deleteCartProductByID,
        queryParameters: {
          'id': cartId,
        },
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Cart>> getAllCartProducts() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpServices.get(
        Constant.cart,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            "Authorization": token,
          },
        ),
      );
      List<Cart> lstCartProducts = [];
      if (response.statusCode == 200) {
        CartResponse cartResponse = CartResponse.fromJson(response.data);
        lstCartProducts = cartResponse.data!;
        return lstCartProducts;
      } else {
        return [];
      }
    } catch (e) {
      // return [];
      throw Exception(e.toString());
    }
  }
}
