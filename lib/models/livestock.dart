class Livestock {
  final String id;
  final String name;
  final String category;
  final double price;
  final double weight;
  final String description;
  final String imageUrl;
  final String location;

  Livestock({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.weight,
    required this.description,
    required this.imageUrl,
    required this.location,
  });

  factory Livestock.fromJson(Map<String, dynamic> json) {
    return Livestock(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['title'] ?? 'Ternak',
      category: json['category'] ?? 'Sapi',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? json['thumbnail'] ?? 'https://via.placeholder.com/150',
      location: json['location'] ?? 'Buleleng',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'weight': weight,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
    };
  }
}