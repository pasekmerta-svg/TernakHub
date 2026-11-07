import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/livestock_provider.dart';
import '../widgets/livestock_card.dart';
import 'livestock_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LivestockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TernakHub Buleleng', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Hero
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Pasar Ternak Digital Buleleng',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Cari ternak berkualitas (Sapi, Kambing, Domba) langsung dari peternak lokal.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              child: Text('Rekomendasi Ternak Hari Ini'),
            ),
            const SizedBox(height: 8),

            // State Handling (Loading, Error, Empty, Loaded)
            if (provider.catalogState == LoadingState.loading)
              const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()))
            else if (provider.catalogState == LoadingState.error)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Gagal memuat data: ${provider.catalogError}', style: const TextStyle(color: Colors.red)),
                ),
              )
            else if (provider.catalog.isEmpty)
              const Center(child: Padding(padding: EdgeInsets.all(16), child: Text('Belum ada data ternak.')))
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: provider.catalog.length > 5 ? 5 : provider.catalog.length,
                itemBuilder: (context, index) {
                  final item = provider.catalog[index];
                  return LivestockCard(
                    item: item,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LivestockDetailScreen(livestock: item)),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}