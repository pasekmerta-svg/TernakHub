class SavedLivestock {
  final String? id;
  final String livestockName;
  final double price;
  final String sellerPhone;
  final String notes;
  final DateTime createdAt;

  SavedLivestock({
    this.id,
    required this.livestockName,
    required this.price,
    required this.sellerPhone,
    required this.notes,
    required this.createdAt,
  });

  // Untuk membaca data dari Supabase Backend Database
  factory SavedLivestock.fromJson(Map<String, dynamic> json) {
    return SavedLivestock(
      id: json['id']?.toString(),
      livestockName: json['livestock_name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      sellerPhone: json['seller_phone'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Untuk mengirim data ke Supabase (Create / Update)
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'livestock_name': livestockName,
      'price': price,
      'seller_phone': sellerPhone,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}