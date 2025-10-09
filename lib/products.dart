import 'package:flutter/material.dart';
import 'dart:convert';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // Mock JSON string simulating API response
  final String _mockJson = '''
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

  List<Map<String, dynamic>> _products = [];

  // Function to parse JSON and extract product list
  List<Map<String, dynamic>> _extractProductsFromJson(String jsonStr) {
    final List<dynamic> decoded = json.decode(jsonStr);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    _products = _extractProductsFromJson(_mockJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Headphones",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 1.2,
              color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF00796B),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final product = _products[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        product["image"],
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00796B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product["description"],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "\$${product["price"].toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
