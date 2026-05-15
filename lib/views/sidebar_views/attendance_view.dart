import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import 'punch_in_view.dart';
import '../../widgets/stat_card.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width <= 700;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(24, isMobile ? 100 : 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile) ...[
              Text(
                'Attendance',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Today's Status Card
            _buildTodayStatusCard(context, isMobile),
            const SizedBox(height: 32),

            Text(
              'Quick Stats',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            
            // Stats Grid
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildCompactStat(context, 'Present', '22', Icons.calendar_today_rounded, Colors.blue, constraints.maxWidth),
                    _buildCompactStat(context, 'Avg Hours', '8.5h', Icons.timer_rounded, Colors.orange, constraints.maxWidth),
                    _buildCompactStat(context, 'Late', '02', Icons.warning_rounded, Colors.red, constraints.maxWidth),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Logs',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildHistoryTable(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PunchInView()),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.fingerprint_rounded),
        label: const Text('Punch In'),
      ),
    );
  }

  Widget _buildTodayStatusCard(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.primaryColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Status',
                    style: GoogleFonts.outfit(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Not Punched In',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.watch_later_outlined, color: Colors.white, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white24),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimeInfo('Check In', '--:--'),
              _buildTimeInfo('Check Out', '--:--'),
              _buildTimeInfo('Total Hours', '0h 0m'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String label, String time) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactStat(BuildContext context, String title, String value, IconData icon, Color color, double maxWidth) {
    final double cardWidth = (maxWidth - 32) / 3;
    return Container(
      width: cardWidth < 100 ? double.infinity : cardWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTable(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(AppTheme.sidebarBg),
          horizontalMargin: 20,
          columnSpacing: 24,
          columns: [
            DataColumn(label: Text('Date', style: GoogleFonts.outfit(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('In', style: GoogleFonts.outfit(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Out', style: GoogleFonts.outfit(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Status', style: GoogleFonts.outfit(fontWeight: FontWeight.bold))),
          ],
          rows: [
            _buildRow('15 May', '09:00 AM', '06:00 PM', 'On Time', Colors.green),
            _buildRow('14 May', '09:15 AM', '06:10 PM', 'Late', Colors.orange),
            _buildRow('13 May', '08:55 AM', '05:45 PM', 'On Time', Colors.green),
            _buildRow('12 May', '09:02 AM', '06:05 PM', 'On Time', Colors.green),
          ],
        ),
      ),
    );
  }

  DataRow _buildRow(String date, String checkIn, String checkOut, String status, Color statusColor) {
    return DataRow(cells: [
      DataCell(Text(date, style: GoogleFonts.outfit(fontSize: 13))),
      DataCell(Text(checkIn, style: GoogleFonts.outfit(fontSize: 13))),
      DataCell(Text(checkOut, style: GoogleFonts.outfit(fontSize: 13))),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status,
            style: GoogleFonts.outfit(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ]);
  }
}
