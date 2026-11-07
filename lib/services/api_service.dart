import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/livestock.dart';

class ApiService {
  // Menggunakan Dummy JSON Mock Data untuk Katalog Ternak REST API
  static const String baseUrl = 'https://dummyjson.com/products/category/groceries';

  Future<List<Livestock>> fetchLivestockList() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> products = data['products'] ?? [];

        // Pemetaan data DummyJSON ke Model Livestock
        return products.asMap().entries.map((entry) {
          int index = entry.key;
          var item = entry.value;

          List<String> categories = ['Sapi Bali', 'Kambing Etawa', 'Domba Garut', 'Sapi Simmental'];
          List<String> locations = ['Singaraja', 'Seririt', 'Gerokgak', 'Sawan', 'Sukasada'];

          return Livestock(
            id: item['id'].toString(),
            name: item['title'] ?? 'Hewan Ternak',
            category: categories[index % categories.length],
            price: ((item['price'] as num).toDouble()) * 150000, // Konversi ke estimasi Rp
            weight: (index + 1) * 45.0 + 120, // Simulasi berat ternak (kg)
            description: item['description'] ?? 'Ternak sehat dan terawat baik.',
            imageUrl: item['thumbnail'] ?? 'https://via.placeholder.com/150',
            location: locations[index % locations.length],
          );
        }).toList();
      } else {
        throw Exception('Gagal mengambil data ternak dari REST API (Code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Kesalahan Koneksi REST API: $e');
    }
  }
}