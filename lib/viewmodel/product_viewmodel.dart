import 'package:flutter/foundation.dart';
import 'package:payments/model/product_model.dart';
import 'package:payments/repos/nativeproducts_repo.dart';
import 'package:payments/repos/product_repo.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductRepository repository;

  ProductsViewModel({ProductRepository? repository})
      : repository = repository ?? NativeProductRepository();

  List<Product> products = [];
  final List<Product> cart = [];
  bool isLoading = true;
  String? error;

  Future<void> loadProducts(String token) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final fetched = await repository.fetchProducts(token);
      products = fetched;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    // use product equality by id
    if (!cart.any((p) => p.id == product.id)) {
      cart.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    final removed = cart.removeWhere((p) => p.id == product.id);
    // removeWhere returns void, so check membership before/after:
    if (!cart.any((p) => p.id == product.id)) {
      notifyListeners();
    }
  }

  double get total => cart.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
}

// class ProductsViewModel extends ChangeNotifier {
//   List<Map<String, dynamic>> products = [];
//   final List<Map<String, dynamic>> cart = [];
//   bool isLoading = true;

//   List<Map<String, dynamic>> _extractProductsFromJson(String jsonStr) {
//     final List<dynamic> decoded = json.decode(jsonStr);
//     return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
//   }

//   Future<void> loadProducts(String token) async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final NativeResponse productResponse =
//           await NativeService.getProducts(token);
//       if (productResponse.success == true && productResponse.data != null) {
//         products = _extractProductsFromJson(productResponse.data!);
//       }
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   void addToCart(Map<String, dynamic> product) {
//     if (!cart.contains(product)) {
//       cart.add(product);
//       notifyListeners();
//     }
//   }

//   void removeFromCart(Map<String, dynamic> product) {
//     if (cart.remove(product)) {
//       notifyListeners();
//     }
//   }

//   double get total => cart.fold(0.0, (sum, item) {
//         final price = item['price'];
//         if (price is int) return sum + price.toDouble();
//         if (price is double) return sum + price;
//         return sum;
//       });
// }
