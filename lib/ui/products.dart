// ...existing code...
import 'package:flutter/material.dart';
import 'package:payments/repos/nativeproducts_repo.dart';
import 'package:payments/ui/login.dart';
import 'package:payments/viewmodel/product_viewmodel.dart';
import 'package:payments/ui/payments.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  final String? token;
  const Products({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductsViewModel>(
      create: (_) {
        final vm = token != null
            ? ProductsViewModel()
            : ProductsViewModel(repository: FakeProductRepository([]));
        vm.loadProducts(token);
        return vm;
      },
      child: Consumer<ProductsViewModel>(
        builder: (context, vm, _) {
          void showCartDialog() {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Cart"),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: vm.cart.length,
                    itemBuilder: (context, index) {
                      final item = vm.cart[index];
                      return ListTile(
                        leading: Image.asset(
                            item.image ?? "assets/placeholder.jpg",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover),
                        title: Text(item.name),
                        subtitle: Text(item.price != null
                            ? "\$${item.price!.toStringAsFixed(2)}"
                            : item.id.toString()),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payments(vm.total),
                        ),
                      );
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

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Products",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1.2,
                    color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Color(0xFF00796B),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
            body: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: vm.products.length,
                      itemBuilder: (context, index) {
                        final product = vm.products[index];
                        final inCart = vm.cart.contains(product);
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
                                    product.image ?? "assets/placeholder.jpg",
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF00796B),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        product.description ?? "-",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Text(
                                            product.price != null
                                                ? "\$${product.price!.toStringAsFixed(2)}"
                                                : "Id: ${product.id.toString()}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green,
                                            ),
                                          ),
                                          const Spacer(),
                                          inCart
                                              ? ElevatedButton.icon(
                                                  onPressed: () => vm
                                                      .removeFromCart(product),
                                                  label: const Text(
                                                      "Remove from Cart"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                  ),
                                                )
                                              : ElevatedButton.icon(
                                                  onPressed: () =>
                                                      vm.addToCart(product),
                                                  icon: const Icon(
                                                    Icons.add_shopping_cart,
                                                    color: Colors.white,
                                                  ),
                                                  label:
                                                      const Text("Add to Cart"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFF00796B),
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
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
            floatingActionButton: vm.cart.isNotEmpty
                ? FloatingActionButton.extended(
                    onPressed: showCartDialog,
                    backgroundColor: Color(0xFF00796B),
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Cart (${vm.cart.length})",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
