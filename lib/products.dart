import 'package:flutter/material.dart';
import 'package:payments/model/native_response.dart';
import 'dart:convert';
import 'package:payments/utils/native_service.dart';
import 'package:payments/payments.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Map<String, dynamic>> _products = [];
  bool isLoading = true;
  final List<Map<String, dynamic>> _cart = [];

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
    if (productResponse.success == true && productResponse.data != null) {
      setState(() {
        if (mounted) {
          isLoading = false;
          _products = _extractProductsFromJson(productResponse.data!);
        }
      });
    }
  }

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      if (!_cart.contains(product)) {
        _cart.add(product);
      }
    });
  }

  void _removeFromCart(Map<String, dynamic> product) {
    setState(() {
      _cart.remove(product);
    });
  }

  void _showCartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cart"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _cart.length,
            itemBuilder: (context, index) {
              final item = _cart[index];
              return ListTile(
                leading: Image.asset(item["image"],
                    width: 40, height: 40, fit: BoxFit.cover),
                title: Text(item["name"]),
                subtitle: Text("\$${item["price"].toStringAsFixed(2)}"),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00796B),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              _onCartButtonPressed();
            },
            child: Text(
              'Pay Now',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _goToPaymentsScreen(double totalAmount) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Payments(totalAmount),
      ),
    );
  }

  void _onCartButtonPressed() {
    double total =
        _cart.fold(0, (sum, item) => sum + (item["price"] as double));
    _goToPaymentsScreen(total);
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
              final inCart = _cart.contains(product);
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
                            Row(
                              children: [
                                Text(
                                  "\$${product["price"].toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                                const Spacer(),
                                inCart
                                    ? ElevatedButton.icon(
                                        onPressed: () =>
                                            _removeFromCart(product),
                                        label: const Text("Remove from Cart"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                        ),
                                      )
                                    : ElevatedButton.icon(
                                        onPressed: () => _addToCart(product),
                                        icon: const Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.white,
                                        ),
                                        label: const Text("Add to Cart"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF00796B),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                        ),
                                      ),
                              ],
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
      floatingActionButton: _cart.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _showCartDialog,
              backgroundColor: Color(0xFF00796B),
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                "Cart (${_cart.length})",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
    );
  }
}
