import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickboom_app/core/theme.dart';
import '../../widgets/stat_card.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: const AttendanceCard().animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
          ),
        ),
        _buildStatGrid(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dashboard',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'CRM, revenue & operations summary.',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (MediaQuery.of(context).size.width > 600) ...[
                  _buildHeaderBadge(context, '3 credits', Colors.green, Icons.monetization_on_outlined),
                  const SizedBox(width: 12),
                  _buildHeaderBadge(context, 'Online', Colors.green, Icons.wifi),
                ],
              ],
            ),
            if (MediaQuery.of(context).size.width <= 600) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildHeaderBadge(context, '3 credits', Colors.green, Icons.monetization_on_outlined),
                  _buildHeaderBadge(context, 'Online', Colors.green, Icons.wifi),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
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
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 145,
        ),
        delegate: SliverChildListDelegate([
          const StatCard(
            title: 'TOTAL LEADS',
            value: '1',
            subtitle: '0 hot leads',
            icon: Icons.person_add_alt_1_rounded,
          ),
          const StatCard(
            title: 'HOT LEADS',
            value: '0',
            subtitle: 'Ready to convert',
            icon: Icons.whatshot_rounded,
            iconColor: Colors.orange,
          ),
          const StatCard(
            title: 'OPEN PROPOSALS',
            value: '0',
            subtitle: '0 approved',
            icon: Icons.description_rounded,
            iconColor: Colors.amber,
          ),
          const StatCard(
            title: 'TOTAL CUSTOMERS',
            value: '0',
            subtitle: 'Unique clients',
            icon: Icons.check_circle_rounded,
            iconColor: Colors.purple,
          ),
          const StatCard(
            title: 'REVENUE COLLECTED',
            value: '₹0',
            subtitle: '0 payments done',
            icon: Icons.currency_rupee_rounded,
            iconColor: Colors.green,
          ),
          const StatCard(
            title: 'PENDING PAYMENTS',
            value: '₹0',
            subtitle: '0 outstanding',
            icon: Icons.hourglass_empty_rounded,
            iconColor: Colors.deepOrange,
          ),
          const StatCard(
            title: 'TOTAL PROJECTS',
            value: '2',
            subtitle: '2 active',
            icon: Icons.folder_rounded,
            iconColor: Colors.lightGreen,
          ),
          const StatCard(
            title: 'DELIVERED',
            value: '0',
            subtitle: '0 in bug fix',
            icon: Icons.check_circle_rounded,
            iconColor: Colors.teal,
          ),
          const StatCard(
            title: 'EXPENSES (MONTH)',
            value: '₹0',
            subtitle: '0 pending',
            icon: Icons.payments_rounded,
            iconColor: Colors.redAccent,
          ),
          const StatCard(
            title: 'TEAM PRESENT',
            value: '1/1',
            subtitle: '0 on leave',
            icon: Icons.groups_rounded,
            iconColor: Colors.cyan,
          ),
          const StatCard(
            title: 'PACKAGES',
            value: '8',
            subtitle: 'Active plans',
            icon: Icons.inventory_2_rounded,
            iconColor: Colors.orangeAccent,
          ),
          const StatCard(
            title: 'BUSINESSES EXTRACTED',
            value: '0',
            subtitle: 'Total data',
            icon: Icons.business_rounded,
            iconColor: Colors.blueGrey,
          ),
          const StatCard(
            title: 'SEARCHES TODAY',
            value: '0',
            subtitle: 'Quota usage',
            icon: Icons.search_rounded,
            iconColor: Colors.blue,
          ),
          const StatCard(
            title: 'API STATUS',
            value: 'Active',
            subtitle: 'Healthy',
            icon: Icons.api_rounded,
            iconColor: Colors.green,
          ),
        ].animate(interval: 50.ms).fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95))),
      ),
    );
  }
}
