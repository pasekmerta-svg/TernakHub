import 'package:flutter/material.dart';
import '../models/livestock.dart';

class LivestockCard extends StatelessWidget {
  final Livestock item;
  final VoidCallback onTap;

  const LivestockCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.pets, size: 50, color: Colors.green),
          ),
        ),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.category} • ${item.location}'),
            const SizedBox(height: 4),
            Text(
              'Rp ${item.price.toStringAsFixed(0)}',
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}