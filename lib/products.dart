import 'package:flutter/material.dart';
import 'package:payments/model/NativeResponse.dart';
import 'dart:convert';

import 'package:payments/utils/native_service.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  List<Map<String, dynamic>> _products = [];
  bool isLoading = true;

  // Function to parse JSON and extract product list
  List<Map<String, dynamic>> _extractProductsFromJson(String jsonStr) {
    final List<dynamic> decoded = json.decode(jsonStr);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    NativeResponse productResponse = await NativeService.getProducts();
    if(productResponse.success == true && productResponse.data != null){
      setState(() {
        if(mounted){
          isLoading = false;
          _products = _extractProductsFromJson(productResponse.data!);
        }
      });
    }
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
        child: Visibility(
          visible: !isLoading,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
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
      ),
    );
  }
}
