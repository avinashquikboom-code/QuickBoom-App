import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

class ProposalsView extends StatelessWidget {
  const ProposalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseViewLayout(
      title: 'Proposals',
      icon: Icons.description_rounded,
      child: Column(
        children: [
          _buildItemCard('Design System Update', 'Rahul Sharma', 'Pending', Colors.orange),
          _buildItemCard('Mobile App Revamp', 'Priya Patel', 'Accepted', Colors.green),
          _buildItemCard('Backend Integration', 'Suresh Kumar', 'Expired', Colors.red),
        ],
      ),
    );
  }
}

class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseViewLayout(
      title: 'Customers',
      icon: Icons.person_search_rounded,
      child: Column(
        children: [
          _buildCustomerItem('Amit Sharma', 'Enterprise Client', 'Active'),
          _buildCustomerItem('Neha Gupta', 'Startup Founder', 'Inactive'),
          _buildCustomerItem('Vikram Singh', 'Individual Pro', 'Active'),
        ],
      ),
    );
  }

  Widget _buildCustomerItem(String name, String type, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
            child: Text(name[0], style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(type, style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status == 'Active' ? Colors.green.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(status, style: TextStyle(color: status == 'Active' ? Colors.green : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseViewLayout(
      title: 'Projects',
      icon: Icons.folder_rounded,
      child: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : (MediaQuery.of(context).size.width > 800 ? 2 : 1),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          _buildProjectCard('QuickBoom UI', '80%', Colors.blue),
          _buildProjectCard('Sales CRM', '45%', Colors.purple),
          _buildProjectCard('API Bridge', '100%', Colors.green),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String progress, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.folder_rounded, color: color),
          const Spacer(),
          Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: double.parse(progress.replaceAll('%', '')) / 100,
                  backgroundColor: color.withValues(alpha: 0.1),
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 12),
              Text(progress, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

class AIGeneratorView extends StatelessWidget {
  const AIGeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseViewLayout(
      title: 'AI Generator',
      icon: Icons.auto_awesome_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToolCard('Copywriter', 'Generate headlines & body text', Icons.edit_note_rounded),
          _buildToolCard('Image AI', 'Create stunning visuals for ads', Icons.image_search_rounded),
          _buildToolCard('Lead AI', 'Predict lead conversion rates', Icons.insights_rounded),
        ],
      ),
    );
  }

  Widget _buildToolCard(String title, String desc, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(desc, style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        ],
      ),
    );
  }
}

class SMMWorkflowView extends StatelessWidget {
  const SMMWorkflowView({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderView(title: 'SMM Workflow', icon: Icons.hub_rounded);
}

class AIPublisherView extends StatelessWidget {
  const AIPublisherView({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderView(title: 'AI Publisher', icon: Icons.send_rounded);
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseViewLayout(
      title: 'Settings',
      icon: Icons.settings_rounded,
      child: Column(
        children: [
          _buildSettingsTile('Profile Information', 'Edit your name, email and avatar', Icons.person_outline_rounded),
          _buildSettingsTile('Notifications', 'Manage app and email alerts', Icons.notifications_none_rounded),
          _buildSettingsTile('Security', 'Password and two-factor auth', Icons.security_rounded),
          _buildSettingsTile('Appearance', 'Themes and layout options', Icons.palette_outlined),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(String title, String desc, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: AppTheme.textPrimary, size: 20),
      ),
      title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
      subtitle: Text(desc, style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textSecondary)),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: () {},
    );
  }
}

class _BaseViewLayout extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _BaseViewLayout({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width <= 700;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, isMobile ? 100 : 24, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) ...[
            Row(
              children: [
                Icon(icon, color: AppTheme.primaryColor, size: 28),
                const SizedBox(width: 12),
                Text(title, style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              ],
            ),
            const SizedBox(height: 32),
          ],
          child,
        ],
      ),
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final String title;
  final IconData icon;
  const _PlaceholderView({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return _BaseViewLayout(
      title: title,
      icon: icon,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(color: AppTheme.primaryColor.withValues(alpha: 0.05), shape: BoxShape.circle),
              child: Icon(icon, size: 64, color: AppTheme.primaryColor.withValues(alpha: 0.2)),
            ),
            const SizedBox(height: 24),
            Text('$title module is coming soon', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('We are working on this feature!'),
          ],
        ),
      ),
    );
  }
}

Widget _buildItemCard(String title, String client, String status, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppTheme.borderSide),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(client, style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontSize: 13)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
