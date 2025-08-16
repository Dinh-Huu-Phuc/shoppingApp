class Product {
  final String id;
  final String name;
  final String image; // assets path
  final String brand;
  final String categoryId;
  final double price;
  final double? salePrice; // optional discount
  final List<String> sizes; // eg: ["S","M","L","XL"]
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.image,
    required this.brand,
    required this.categoryId,
    required this.price,
    this.salePrice,
    required this.sizes,
    required this.description,
  });

  bool get onSale => salePrice != null && salePrice! < price;
  double get effectivePrice => salePrice ?? price;
}


