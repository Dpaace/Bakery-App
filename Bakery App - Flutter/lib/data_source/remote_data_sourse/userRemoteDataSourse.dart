import 'package:bakey/app/constant.dart';
import 'package:bakey/data_source/remote_data_sourse/response/LoginResponse.dart';
import 'package:bakey/data_source/remote_data_sourse/response/user_orders.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/http_services.dart';
import '../../model/user.dart';

class UserRemoteDataSourse {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<User?> getUserDetails() async {
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
      User? user;
      if (response.statusCode == 200) {
        UserOrdersResponse userResponse =
            UserOrdersResponse.fromJson(response.data);
        user = userResponse.data!;
        return user;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> addUser(User user) async {
    try {
      Response response = await _httpServices.post(
        Constant.registerUser,
        data: {
          'firstName': user.firstName,
          'lastName': user.lastName,
          'phoneNumber': user.phoneNumber,
          'email': user.email,
          'password': user.password,
        },
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

  Future<int> addAdmin(User user) async {
    try {
      Response response = await _httpServices.post(
        Constant.registerUser,
        data: {
          "firstName": user.firstName,
          "lastName": user.lastName,
          'email': user.email,
          'password': user.password,
          "role": user.role,
        },
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

  Future<bool> loginUser(String email, String password) async {
    try {
      Response response = await _httpServices.post(
        Constant.loginUser,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token!}";
        addToken(loginResponse.token!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginAdmin(String email, String password) async {
    try {
      Response response = await _httpServices.post(
        Constant.loginAdmin,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token!}";
        addToken(loginResponse.token!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void addToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', "Bearer $token");
    // await pref.setString('login', token);
  }
}
