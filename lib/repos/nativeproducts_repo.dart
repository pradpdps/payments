// New file
import 'dart:convert';
import 'package:payments/model/product_model.dart';
import 'package:payments/repos/product_repo.dart';
import 'package:payments/utils/native_service.dart';
import 'package:payments/viewmodel/native_response.dart';

class NativeProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetchProducts(String? token) async {
    final NativeResponse resp = await NativeService.getProducts(token!);
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

class FakeProductRepository implements ProductRepository {
  final List<Product> items;
  FakeProductRepository(this.items);

  @override
  Future<List<Product>> fetchProducts(String? token) async {
    const String productsJson = '''
[
  {
    "name": "Bass Boost Headphones",
    "price": 79.99,
    "description": "Experience deep bass and crisp sound with these stylish headphones.",
    "image": "assets/h1.webp"
  },
  {
    "name": "Wireless Comfort Headphones",
    "price": 99.99,
    "description": "Enjoy wireless freedom and all-day comfort with soft ear cushions.",
    "image": "assets/h2.webp"
  },
  {
    "name": "Studio Pro Headphones",
    "price": 149.99,
    "description": "Perfect for studio recording and mixing, with premium sound quality.",
    "image": "assets/h3.jpg"
  },
  {
    "name": "Travel Lite Headphones",
    "price": 59.99,
    "description": "Lightweight and foldable, ideal for travel and daily commutes.",
    "image": "assets/h1.webp"
  },
  {
    "name": "Gaming Surround Headphones",
    "price": 129.99,
    "description": "Immersive surround sound for gaming and entertainment.",
    "image": "assets/h2.webp"
  }
]
''';

    final List<Product> items =
        (json.decode(productsJson) as List).asMap().entries.map((entry) {
      final idx = entry.key;
      final Map<String, dynamic> map = Map<String, dynamic>.from(entry.value);
      map['id'] = map['id'] ?? (idx + 1).toString();
      return Product.fromJson(map);
    }).toList();
    return items;
  }
}
