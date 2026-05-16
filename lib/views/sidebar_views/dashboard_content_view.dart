import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickboom_app/core/theme.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/charts_section.dart';

class DashboardContentView extends StatelessWidget {
  const DashboardContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width <= 700;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (isMobile) const SliverToBoxAdapter(child: SizedBox(height: 100)),
        _buildHeader(context),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          sliver: SliverToBoxAdapter(
            child: const AttendanceCard()
                .animate()
                .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                .slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOut),
          ),
        ),
        _buildSectionTitle('Performance Insights'),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          sliver: SliverToBoxAdapter(
            child: const ChartsSection()
                .animate()
                .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                .slideY(begin: 0.1, end: 0, duration: 800.ms, curve: Curves.easeOut),
          ),
        ),
        _buildSectionTitle('Operational Metrics'),
        _buildStatGrid(context),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      sliver: SliverToBoxAdapter(
        child: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppTheme.textSecondary.withValues(alpha: 0.6),
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Welcome back,',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.waving_hand_rounded, size: 16, color: Color(0xFFFFD700)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Avinash Magar',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: AppTheme.textPrimary,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
                if (MediaQuery.of(context).size.width > 600) ...[
                  _buildHeaderBadge(context, '3 Credits', AppTheme.primaryColor, Icons.bolt_rounded),
                  const SizedBox(width: 12),
                  _buildHeaderBadge(context, 'System Live', AppTheme.successColor, Icons.sensors_rounded),
                ],
              ],
            ),
            if (MediaQuery.of(context).size.width <= 600) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildHeaderBadge(context, '3 Credits', AppTheme.primaryColor, Icons.bolt_rounded),
                  _buildHeaderBadge(context, 'System Live', AppTheme.successColor, Icons.sensors_rounded),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBadge(BuildContext context, String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.outfit(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatGrid(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 160,
        ),
        delegate: SliverChildListDelegate([
          const StatCard(
            title: 'TOTAL LEADS',
            value: '1,284',
            subtitle: '+12% from last month',
            icon: Icons.person_add_alt_1_rounded,
            iconColor: AppTheme.primaryColor,
          ),
          const StatCard(
            title: 'HOT LEADS',
            value: '42',
            subtitle: 'Ready to convert',
            icon: Icons.whatshot_rounded,
            iconColor: Colors.orange,
          ),
          const StatCard(
            title: 'OPEN PROPOSALS',
            value: '18',
            subtitle: '4 pending review',
            icon: Icons.description_rounded,
            iconColor: Colors.amber,
          ),
          const StatCard(
            title: 'TOTAL CUSTOMERS',
            value: '856',
            subtitle: 'Active accounts',
            icon: Icons.check_circle_rounded,
            iconColor: Colors.purple,
          ),
          const StatCard(
            title: 'REVENUE COLLECTED',
            value: '₹4.2L',
            subtitle: 'This quarter',
            icon: Icons.currency_rupee_rounded,
            iconColor: Colors.green,
          ),
          const StatCard(
            title: 'PENDING PAYMENTS',
            value: '₹84K',
            subtitle: 'Overdue items',
            icon: Icons.hourglass_empty_rounded,
            iconColor: Colors.deepOrange,
          ),
          const StatCard(
            title: 'TOTAL PROJECTS',
            value: '12',
            subtitle: '8 active now',
            icon: Icons.folder_rounded,
            iconColor: Colors.lightGreen,
          ),
          const StatCard(
            title: 'DELIVERED',
            value: '142',
            subtitle: 'Completed tasks',
            icon: Icons.verified_rounded,
            iconColor: Colors.teal,
          ),
        ].animate(interval: 50.ms).fadeIn(duration: 500.ms, curve: Curves.easeOut).slideY(begin: 0.1, end: 0)),
      ),
    );
  }
}
