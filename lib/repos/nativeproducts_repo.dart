// New file
import 'dart:convert';
import 'package:payments/model/product_model.dart';
import 'package:payments/repos/product_repo.dart';
import 'package:payments/utils/native_service.dart';
import 'package:payments/viewmodel/native_response.dart';

class NativeProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetchProducts(String token) async {
    final NativeResponse resp = await NativeService.getProducts(token);
    if (resp.success != true || resp.data == null) return [];
    try {
      final dynamic raw = resp.data;
      if (raw is String) {
        final List<dynamic> decoded = json.decode(raw);
        return decoded
            .map((e) => Product.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else if (raw is List) {
        return raw
            .map((e) => Product.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else if (raw is Map) {
        return [Product.fromJson(Map<String, dynamic>.from(raw))];
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }
}
