import 'package:flutter/foundation.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => [..._items];

  int get itemCount => _items.length;

  bool isFavorite(Map<String, dynamic> product) {
    return _items.any((item) => item['name'] == product['name']);
  }

  void toggleFavorite(Map<String, dynamic> product) {
    final isExist = _items.any((item) => item['name'] == product['name']);
    if (isExist) {
      _items.removeWhere((item) => item['name'] == product['name']);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  void removeItem(Map<String, dynamic> product) {
    _items.removeWhere((item) => item['name'] == product['name']);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
} 