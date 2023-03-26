class Constant {
  // static const String baseURL = "http://10.0.2.2:5000";
  // static const String baseURL = "http://192.168.1.18:5000";

  // For unit test use localhost URL
  static const String baseURL = "http://localhost:5000/";

  static const String registerUser = "/user/register";

  static const String loginUser = "/user/login";
  static const String loginAdmin = "/user/adminlogin";

  static const String getAllProductsURL = "/product/";
  static const String deleteProductByID = "/product/delProductByID";
  static const String updateProduct = "/product/update/";

  static const String cart = "/cart/";
  static const String addCartProduct = "/cart/add/";
  static const String deleteCartProductByID = "/cart/delCartProductByID";

  static const String order = "/order/";
  // static const String getUserOrder = "/order/getUserOrder";
  static const String addOrder = "/order/add/";
  static const String updateOrderStatus = "/order/updateOrderStatus/";

  static String token = "";

  static const String productImageURL = "http://10.0.2.2:5000/uploads/";
  // static const String productImageURL = "http://192.168.1.18:5000/uploads/";
  // static const String userImageURL = "http://192.168.1.18:3000/uploads/";
}
