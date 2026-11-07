import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text('Made Pasek Merta Sujati', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('NIM: [Isi NIM Anda di sini]', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const Text('Kelas: [Isi Kelas Anda di sini]', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              const Text('Project UTS Pemrograman Mobile', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text('TernakHub Buleleng - Flutter & Supabase', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}