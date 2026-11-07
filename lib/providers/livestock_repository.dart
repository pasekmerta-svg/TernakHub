import 'package:flutter/material.dart';
import '../models/livestock.dart';
import '../models/saved_livestock.dart';
import '../repositories/livestock_repository.dart';

enum LoadingState { initial, loading, loaded, error }

class LivestockProvider extends ChangeNotifier {
  final LivestockRepository _repository = LivestockRepository();

  // State REST API Katalog
  List<Livestock> _catalog = [];
  LoadingState _catalogState = LoadingState.initial;
  String _catalogError = '';

  // State Supabase Database (Saved / Favorites)
  List<SavedLivestock> _savedItems = [];
  LoadingState _savedState = LoadingState.initial;
  String _savedError = '';

  // Getter
  List<Livestock> get catalog => _catalog;
  LoadingState get catalogState => _catalogState;
  String get catalogError => _catalogError;

  List<SavedLivestock> get savedItems => _savedItems;
  LoadingState get savedState => _savedState;
  String get savedError => _savedError;

  // READ Catalog REST API
  Future<void> fetchCatalog() async {
    _catalogState = LoadingState.loading;
    notifyListeners();
    try {
      _catalog = await _repository.getCatalog();
      _catalogState = LoadingState.loaded;
    } catch (e) {
      _catalogError = e.toString();
      _catalogState = LoadingState.error;
    }
    notifyListeners();
  }

  // READ Saved Items Supabase
  Future<void> fetchSavedItems() async {
    _savedState = LoadingState.loading;
    notifyListeners();
    try {
      _savedItems = await _repository.getSavedItems();
      _savedState = LoadingState.loaded;
    } catch (e) {
      _savedError = e.toString();
      _savedState = LoadingState.error;
    }
    notifyListeners();
  }

  // CREATE Item Supabase
  Future<bool> addSavedItem(SavedLivestock item) async {
    try {
      await _repository.addSavedItem(item);
      await fetchSavedItems();
      return true;
    } catch (e) {
      return false;
    }
  }

  // UPDATE Item Supabase
  Future<bool> updateSavedItem(SavedLivestock item) async {
    try {
      await _repository.updateSavedItem(item);
      await fetchSavedItems();
      return true;
    } catch (e) {
      return false;
    }
  }

  // DELETE Item Supabase
  Future<bool> deleteSavedItem(String id) async {
    try {
      await _repository.deleteSavedItem(id);
      await fetchSavedItems();
      return true;
    } catch (e) {
      return false;
    }
  }
}