import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:white_tiger_shop/common/model/base_model.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class CartModel extends BaseModel<Map<int, Product>> {
  Map<int, Product> _products = {};
  @override
  Map<int, Product> get data => _products;
  Box? cartBox;

  CartModel() {
    update();
  }

  void updateLocalCart() async {
    await cartBox!.put('cart', _products);
  }

  Map<int, Product> addToCart(Product newProd) {
    if (!_products.keys.contains(newProd.productId)) {
      _products[newProd.productId] = newProd;
      updateLocalCart();
      notifyListeners();
    }
    return _products;
  }

  bool inCart(Product prod) {
    return _products.keys.contains(prod.productId);
  }

  int getLen() {
    return _products.length;
  }

  void clearCart() {
    _products = {};
    updateLocalCart();
    notifyListeners();
  }

  Map<int, Product> removeFromCart(Product prod) {
    if (_products.keys.contains(prod.productId)) {
      _products.removeWhere((key, value) => key == prod.productId);
      updateLocalCart();
      notifyListeners();
    }
    return _products;
  }

  @override
  Future<void> fetch() async {
    Hive.registerAdapter<Product>(ProductAdapter());
    cartBox = await Hive.openBox('cartBox');
    final saved = cartBox!.get('cart');
    if (saved != null) {
      _products = Map<int, Product>.from(saved);
    }
  }
}
