class ProductCombo {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ProductCombo({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductCombo.fromJson(Map<String, dynamic> json) {
    return ProductCombo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}