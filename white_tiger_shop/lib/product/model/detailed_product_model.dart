import 'package:flutter/material.dart';
import 'package:white_tiger_shop/product/controller/detailed_product_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class DetailedProductModel extends ChangeNotifier {
  final api = DetailedProductApi();
  Product? _product;
  Product? get product => _product;

  Future<void> fetchDetailedProduct(int productId) async {
    _product = await api.getDetailedProduct(productId);
    notifyListeners();
  }
}