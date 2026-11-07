import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_livestock.dart';
import '../providers/livestock_provider.dart';

class AddLivestockScreen extends StatefulWidget {
  final String? initialName;
  final double? initialPrice;

  const AddLivestockScreen({super.key, this.initialName, this.initialPrice});

  @override
  State<AddLivestockScreen> createState() => _AddLivestockScreenState();
}

class _AddLivestockScreenState extends State<AddLivestockScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _priceController = TextEditingController(text: widget.initialPrice?.toStringAsFixed(0) ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Catatan Incaran'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama / Ras Ternak', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'Nama ternak wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Harga (Rp)', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'Harga wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'No. HP Peternak / Penjual', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'Nomor HP wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Catatan Pribadi', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newItem = SavedLivestock(
                      livestockName: _nameController.text,
                      price: double.parse(_priceController.text),
                      sellerPhone: _phoneController.text,
                      notes: _notesController.text,
                      createdAt: DateTime.now(),
                    );

                    final success = await Provider.of<LivestockProvider>(context, listen: false).addSavedItem(newItem);

                    if (mounted) {
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Berhasil disimpan ke Supabase Database!')),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Gagal menyimpan data ke database.')),
                        );
                      }
                    }
                  }
                },
                child: const Text('Simpan Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}