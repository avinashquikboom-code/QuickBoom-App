import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dashboardBg,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _notifications[index];
          return _buildNotificationItem(item);
        },
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: item.isUnread ? AppTheme.primaryColor.withValues(alpha: 0.3) : AppTheme.borderSide),
        boxShadow: [
          if (item.isUnread)
            BoxShadow(
              color: AppTheme.primaryColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: item.color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.type,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: item.color,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      item.time,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.message,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (item.isUnread)
            Container(
              margin: const EdgeInsets.only(left: 8, top: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final String type;
  final IconData icon;
  final Color color;
  final bool isUnread;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.icon,
    required this.color,
    this.isUnread = false,
  });
}

final List<NotificationItem> _notifications = [
  NotificationItem(
    title: 'New Lead Assigned',
    message: 'You have been assigned a new lead from the Website: "Rahul Sharma".',
    time: '2 mins ago',
    type: 'LEAD',
    icon: Icons.person_add_rounded,
    color: Colors.blue,
    isUnread: true,
  ),
  NotificationItem(
    title: 'Punch In Successful',
    message: 'Your check-in was recorded at 09:00 AM. Have a great day!',
    time: '1 hour ago',
    type: 'ATTENDANCE',
    icon: Icons.fingerprint_rounded,
    color: Colors.green,
  ),
  NotificationItem(
    title: 'Proposal Viewed',
    message: 'Client "Amit Patel" has viewed the project proposal for "Q2 Marketing".',
    time: '3 hours ago',
    type: 'PROPOSAL',
    icon: Icons.description_rounded,
    color: Colors.orange,
    isUnread: true,
  ),
  NotificationItem(
    title: 'System Update',
    message: 'Quik Boom v2.4 is now live with new AI analytics features.',
    time: '5 hours ago',
    type: 'SYSTEM',
    icon: Icons.system_update_rounded,
    color: Colors.purple,
  ),
  NotificationItem(
    title: 'Meeting Reminder',
    message: 'Your meeting with the Sales Team starts in 30 minutes.',
    time: 'Yesterday',
    type: 'CALENDAR',
    icon: Icons.event_rounded,
    color: Colors.red,
  ),
];
