import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';
import '../models/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Colors.blue;
      case NotificationType.promo:
        return Colors.green;
      case NotificationType.stock:
        return Colors.orange;
      case NotificationType.general:
        return Colors.grey;
    }
  }

  String _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return '🛍️';
      case NotificationType.promo:
        return '🏷️';
      case NotificationType.stock:
        return '📦';
      case NotificationType.general:
        return '📢';
    }
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} gün önce';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} saat önce';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} dakika önce';
    } else {
      return 'Az önce';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notifications, child) {
              if (notifications.itemCount == 0) return const SizedBox.shrink();
              return PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'mark_all_read',
                    child: Text('Tümünü okundu işaretle'),
                  ),
                  const PopupMenuItem(
                    value: 'clear_all',
                    child: Text('Tümünü temizle'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'mark_all_read') {
                    notifications.markAllAsRead();
                  } else if (value == 'clear_all') {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Bildirimleri Temizle'),
                        content: const Text(
                          'Tüm bildirimleri silmek istediğinizden emin misiniz?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('İptal'),
                          ),
                          TextButton(
                            onPressed: () {
                              notifications.clearAll();
                              Navigator.of(ctx).pop();
                            },
                            style: TextButton.styleFrom(foregroundColor: Colors.red),
                            child: const Text('Temizle'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notifications, child) {
          if (notifications.itemCount == 0) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Bildirim Bulunmuyor',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.itemCount,
            itemBuilder: (context, index) {
              final notification = notifications.items[index];
              return Dismissible(
                key: Key(notification.time.toString()),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  notifications.removeNotification(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bildirim silindi'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getNotificationColor(notification.type).withOpacity(0.2),
                    child: Text(
                      _getNotificationIcon(notification.type),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.message),
                      const SizedBox(height: 4),
                      Text(
                        _getTimeAgo(notification.time),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (!notification.isRead) {
                      notifications.markAsRead(index);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
} 