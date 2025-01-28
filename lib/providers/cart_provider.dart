import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  Map<String, Map<String, dynamic>> _items = {};

  List<Map<String, dynamic>> get items {
    return _items.entries.map((entry) {
      final item = Map<String, dynamic>.from(entry.value);
      item['quantity'] = item['quantity'] ?? 1;
      return item;
    }).toList();
  }

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.values.fold(0.0, (sum, item) {
      return sum + (double.parse(item['price']) * (item['quantity'] ?? 1));
    });
  }

  void addItem(Map<String, dynamic> product) {
    if (_items.containsKey(product['name'])) {
      _items.update(
        product['name'],
        (existingItem) {
          existingItem['quantity'] = (existingItem['quantity'] ?? 1) + 1;
          return existingItem;
        },
      );
    } else {
      _items.putIfAbsent(
        product['name'],
        () => {
          'name': product['name'],
          'price': product['price'],
          'imageUrl': product['imageUrl'],
          'description': product['description'],
          'quantity': 1,
        },
      );
    }
    notifyListeners();
  }

  void removeItem(int index) {
    final key = _items.keys.elementAt(index);
    _items.remove(key);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    final key = _items.keys.elementAt(index);
    if (_items.containsKey(key)) {
      _items[key]!['quantity'] = quantity;
      notifyListeners();
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
} 