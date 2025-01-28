import 'package:flutter/foundation.dart';
import '../models/notification_item.dart';

class NotificationProvider with ChangeNotifier {
  final List<NotificationItem> _items = [
    // Örnek bildirimler
    NotificationItem(
      title: 'Hoş Geldiniz!',
      message: 'E-ticaret uygulamamıza hoş geldiniz. Size özel fırsatları kaçırmayın!',
      time: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.general,
    ),
    NotificationItem(
      title: 'Yeni İndirim',
      message: 'Elektronik ürünlerde %20\'ye varan indirimler başladı!',
      time: DateTime.now().subtract(const Duration(hours: 5)),
      type: NotificationType.promo,
    ),
    NotificationItem(
      title: 'Stok Bildirimi',
      message: 'Favorinizdeki "iPhone 14 Pro Max" ürünü tekrar stokta!',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.stock,
    ),
  ];

  List<NotificationItem> get items => [..._items];

  int get itemCount => _items.length;

  int get unreadCount => _items.where((item) => !item.isRead).length;

  void addNotification(NotificationItem notification) {
    _items.insert(0, notification);
    notifyListeners();
  }

  void markAsRead(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (var item in _items) {
      item.isRead = true;
    }
    notifyListeners();
  }

  void removeNotification(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clearAll() {
    _items.clear();
    notifyListeners();
  }
} 