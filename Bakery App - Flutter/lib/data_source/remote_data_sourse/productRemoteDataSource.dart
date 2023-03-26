import 'dart:io';

import 'package:bakey/app/constant.dart';
import 'package:bakey/data_source/remote_data_sourse/response/product_response.dart';
import 'package:bakey/model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/http_services.dart';

class ProductRemoteDataSourse {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<Product>> getAllProducts() async {
    try {
      Response response = await _httpServices.get(Constant.getAllProductsURL);
      List<Product> lstUserProducts = [];
      if (response.statusCode == 200) {
        ProductResponse postResponse = ProductResponse.fromJson(response.data);
        lstUserProducts = postResponse.data!;
        return lstUserProducts;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<int> addProduct(File? file, Product product) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String token = pref.getString('token')!;

      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }

      FormData formData = FormData.fromMap({
        'name': product.name,
        'price': product.price,
        'weight': product.weight,
        'description': product.description,
        'image': image,
      });

      Response response = await _httpServices.post(
        Constant.getAllProductsURL,
        data: formData,
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

  Future<int> deleteProduct(String productId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpServices.delete(
        Constant.deleteProductByID,
        queryParameters: {
          'id': productId,
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

  Future<int> updateProduct(
      File? file, Product product, String productId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType(
            "image",
            mimeType!.split("/")[1],
          ),
        );
      }

      FormData formData = FormData.fromMap({
        'name': product.name,
        'price': product.price,
        'weight': product.weight,
        'description': product.description,
        'image': image
      });

      Response response = await _httpServices.put(
        Constant.updateProduct,
        queryParameters: {
          'id': productId,
        },
        data: formData,
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
