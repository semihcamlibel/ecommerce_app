class NotificationItem {
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

enum NotificationType {
  order,    // Sipariş bildirimleri
  promo,    // Kampanya bildirimleri
  stock,    // Stok bildirimleri
  general   // Genel bildirimler
} 