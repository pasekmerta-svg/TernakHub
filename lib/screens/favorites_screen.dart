import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/livestock_provider.dart';
import 'add_livestock_screen.dart';
import 'edit_livestock_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LivestockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ternak Incaran Saya (Database)'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddLivestockScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: provider.savedState == LoadingState.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.savedItems.isEmpty
              ? const Center(child: Text('Belum ada ternak tersimpan di database.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: provider.savedItems.length,
                  itemBuilder: (context, index) {
                    final item = provider.savedItems[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(item.livestockName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Rp ${item.price.toStringAsFixed(0)} • HP: ${item.sellerPhone}\nCatatan: ${item.notes}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => EditLivestockScreen(item: item)));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Hapus Data'),
                                    content: Text('Apakah Anda yakin ingin menghapus "${item.livestockName}"?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(ctx);
                                          if (item.id != null) {
                                            await provider.deleteSavedItem(item.id!);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Data ternak berhasil dihapus!')),
                                            );
                                          }
                                        },
                                        child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}