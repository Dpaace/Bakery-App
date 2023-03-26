import 'package:flutter/material.dart';

import '../Screen/adminAddProductScreen.dart';
import '../Screen/adminDashboard.dart';
import '../Screen/adminLogin.dart';
import '../Screen/adminMenu.dart';
import '../Screen/adminOrdersScreen.dart';
import '../Screen/adminProductDescription.dart';
import '../Screen/allAdminProducts.dart';
import '../Screen/dashboad.dart';
import '../Screen/home_screen.dart';
import '../Screen/login.dart';
import '../Screen/product_detail_page.dart';
import '../Screen/register.dart';
import '../Screen/updateOrderStatus.dart';
import '../Screen/updateProduct.dart';
import '../Screen/userOrders.dart';
import '../Screen/wearos/wear_dashboard.dart';
import '../Screen/wearos/wear_login.dart';
import '../Screen/wearos/wear_orders.dart';

var getAppRoutes = <String, WidgetBuilder>{
  LoginScreen.route: (context) => const LoginScreen(),
  AdminLoginScreen.route: (context) => const AdminLoginScreen(),
  Register.route: (context) => const Register(),
  DashboardScreen.route: (context) => const DashboardScreen(),
  WearOSLoginScreen.route: (context) => const WearOSLoginScreen(),
  WearOsDashboard.route: (context) => const WearOsDashboard(),
  GridHomeScreen.route: (context) => const GridHomeScreen(),
  ProductDetailPage.route: (context) => const ProductDetailPage(),
  AdminDashBoard.route: (context) => const AdminDashBoard(),
  AllAdminProductsScreen.route: (context) => const AllAdminProductsScreen(),
  AdminProductDetailScreen.route: (context) => const AdminProductDetailScreen(),
  AdminAddProductScreen.route: (context) => const AdminAddProductScreen(),
  AdminOrdersScreen.route: (context) => const AdminOrdersScreen(),
  UserOrdersScreen.route: (context) => const UserOrdersScreen(),
  ProductUpdateScreen.route: (context) => const ProductUpdateScreen(),
  UpdateOrderStatusScreen.route: (context) => const UpdateOrderStatusScreen(),
  AdminMenuScreen.route: (context) => const AdminMenuScreen(),
  WearOrdersScreen.route: (context) => const WearOrdersScreen(),
};
