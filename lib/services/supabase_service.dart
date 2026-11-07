import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/saved_livestock.dart';

class SupabaseService {
  // Masukkan URL & Key anon dari Project Settings -> API Supabase Anda
  static const String supabaseUrl = 'https://dntgtnrkycvyrnbpaedr.supabase.co';
  static const String supabaseAnonKey = 'PASTE_KEY_ANON_PUBLIC_ANDA_DI_SINI';

  static Future<void> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  final SupabaseClient _client = Supabase.instance.client;

  // READ / GET
  Future<List<SavedLivestock>> getSavedLivestock() async {
    final response = await _client
        .from('ternakhub')
        .select()
        .order('created_at', ascending: false);
    
    return (response as List).map((e) => SavedLivestock.fromJson(e)).toList();
  }

  // CREATE / POST
  Future<void> addSavedLivestock(SavedLivestock data) async {
    await _client.from('ternakhub').insert(data.toJson());
  }

  // UPDATE / PUT
  Future<void> updateSavedLivestock(SavedLivestock data) async {
    if (data.id == null) return;
    await _client.from('ternakhub').update(data.toJson()).eq('id', data.id!);
  }

  // DELETE
  Future<void> deleteSavedLivestock(String id) async {
    await _client.from('ternakhub').delete().eq('id', id);
  }
}