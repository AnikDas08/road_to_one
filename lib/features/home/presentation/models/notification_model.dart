class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final DateTime dateTime;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.dateTime,
    this.isRead = false,
  });
}