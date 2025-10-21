import 'package:payments/model/product_model.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts(String token);
}
