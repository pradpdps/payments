// New file
class Product {
  final String id;
  final String name;
  final String? description;
  final double? price;
  final String? image;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final dynamic p = json;
    String id = (p['id'] ?? p['productId'] ?? p['uuid'] ?? '').toString();
    final name = (p['name'] ?? p['title'] ?? '').toString();
    final description = p['description']?.toString();
    double? price;
    if (p['price'] is num) {
      price = (p['price'] as num).toDouble();
    } else if (p['price'] is String) {
      price = double.tryParse(p['price']);
    }
    final image = p['image']?.toString();
    return Product(
        id: id,
        name: name,
        description: description,
        price: price,
        image: image);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'image': image,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Product && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
