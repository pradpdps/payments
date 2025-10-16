import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:payments/utils/native_service.dart';
import 'package:payments/model/native_response.dart';

class ProductsViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> products = [];
  final List<Map<String, dynamic>> cart = [];
  bool isLoading = true;

  List<Map<String, dynamic>> _extractProductsFromJson(String jsonStr) {
    final List<dynamic> decoded = json.decode(jsonStr);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> loadProducts(String token) async {
    isLoading = true;
    notifyListeners();
    try {
      final NativeResponse productResponse =
          await NativeService.getProducts(token);
      if (productResponse.success == true && productResponse.data != null) {
        products = _extractProductsFromJson(productResponse.data!);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(Map<String, dynamic> product) {
    if (!cart.contains(product)) {
      cart.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(Map<String, dynamic> product) {
    if (cart.remove(product)) {
      notifyListeners();
    }
  }

  double get total => cart.fold(0.0, (sum, item) {
        final price = item['price'];
        if (price is int) return sum + price.toDouble();
        if (price is double) return sum + price;
        return sum;
      });
}
