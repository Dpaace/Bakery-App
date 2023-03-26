import 'dart:io';

import 'package:bakey/data_source/remote_data_sourse/productRemoteDataSource.dart';
import 'package:bakey/model/product_model.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<int> addProduct(File? file, Product product);
  Future<int> deleteProduct(String productId);

  Future<int> updateProduct(File? file, Product product, String productId);
}

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<Product>> getAllProducts() {
    return ProductRemoteDataSourse().getAllProducts();
  }

  @override
  Future<int> addProduct(File? file, Product product) {
    return ProductRemoteDataSourse().addProduct(file, product);
  }

  @override
  Future<int> deleteProduct(String productId) {
    return ProductRemoteDataSourse().deleteProduct(productId);
  }

  @override
  Future<int> updateProduct(File? file, Product product, String productId) {
    return ProductRemoteDataSourse().updateProduct(file, product, productId);
  }
}
