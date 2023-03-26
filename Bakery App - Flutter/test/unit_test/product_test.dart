import 'dart:io';

import 'package:bakey/data_source/remote_data_sourse/cartDataSource.dart';
import 'package:bakey/data_source/remote_data_sourse/orderDataSource.dart';
import 'package:bakey/data_source/remote_data_sourse/productRemoteDataSource.dart';
import 'package:bakey/model/cart_model.dart';
import 'package:bakey/model/order_model.dart';
import 'package:bakey/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "token":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2ZkOTcwNDM5YTI1OGE3NzhlNGVlMTkiLCJlbWFpbCI6ImFkbWluMUBnbWFpbC5jb20iLCJyb2xlIjoiQWRtaW4iLCJpYXQiOjE2Nzc1NjM3MDEsImV4cCI6MTY3NzY1MDEwMX0.IyMArAVOxswXBmLnAHy1f5lNfn9h_zNwW3LJhaqcf58"
    });
  });

  WidgetsFlutterBinding.ensureInitialized();

  test('Get All Products', () async {
    List<Product> actualResult =
        await ProductRemoteDataSourse().getAllProducts();
    expect(actualResult, isNotEmpty);
  });

  test('User should be able to delete Product', () async {
    int expectedResult = 1;
    String productId = "63fd90d1f203f86871481de9";
    int actualResult = await ProductRemoteDataSourse().deleteProduct(productId);
    expect(actualResult, expectedResult);
  });

  test('User should be able to add product', () async {
    int expectedResult = 1;
    File? img;
    Product product = Product(
      name: "Product",
      price: 12,
      weight: "2Kg",
      description: "cake",
    );
    int actualResult = await ProductRemoteDataSourse().addProduct(img, product);
    expect(actualResult, expectedResult);
  });

  test('Get All Orders', () async {
    List<Orders> actualResult = await OrderRemoteDataSourse().getAllOrders();
    expect(actualResult, isNotEmpty);
  });

  test('User should be able to add order', () async {
    int expectedResult = 1;
    String productId = "63fd9030f203f86871481de4";
    int actualResult = await OrderRemoteDataSourse().addOrder(productId);
    expect(actualResult, expectedResult);
  });

  test('Admin should be able to update order status', () async {
    int expectedResult = 1;
    String orderId = "63fd9101f203f86871481df8";
    Orders orders = Orders(
      status: "Completed",
    );
    int actualResult =
        await OrderRemoteDataSourse().updateOrderStatus(orderId, orders);
    expect(actualResult, expectedResult);
  });

  test('User should be able to add to cart', () async {
    int expectedResult = 1;
    String productId = "63fd9030f203f86871481de4";
    int actualResult = await CartRemoteDataSourse().addCartProduct(productId);
    expect(actualResult, expectedResult);
  });

  test('Get All Cart Products', () async {
    List<Cart> actualResult = await CartRemoteDataSourse().getAllCartProducts();
    expect(actualResult, isNotEmpty);
  });

 
}

// flutter test --coverage ./test/unit_test/product_test.dart 
// flutter pub run test_cov_console
