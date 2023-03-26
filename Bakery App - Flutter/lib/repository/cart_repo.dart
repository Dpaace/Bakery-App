import 'package:bakey/data_source/remote_data_sourse/cartDataSource.dart';

import '../model/cart_model.dart';

abstract class CartRepository {
  Future<List<Cart>> getAllCartProducts();
  Future<int> addCart(String productId);
  Future<int> deleteCartProduct(String cartId);
}

class CartRepositoryImpl extends CartRepository {
  @override
  Future<List<Cart>> getAllCartProducts() {
    return CartRemoteDataSourse().getAllCartProducts();
  }

  @override
  Future<int> addCart(String productId) {
    return CartRemoteDataSourse().addCartProduct(productId);
  }

  @override
  Future<int> deleteCartProduct(String cartId) {
    return CartRemoteDataSourse().deleteCartProduct(cartId);
  }
}
