import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/constants.dart';

class Sidebar extends StatelessWidget {
  final SidebarItem currentSelection;
  final Function(SidebarItem) onItemSelected;
  final VoidCallback onLogout;

  const Sidebar({
    super.key,
    required this.currentSelection,
    required this.onItemSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppTheme.sidebarBg,
        border: Border(right: BorderSide(color: AppTheme.borderSide.withValues(alpha: 0.5))),
      ),
      child: Column(
        children: [
          // Logo Section
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 48, 28, 40),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.accentColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quik Boom',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                        letterSpacing: -0.8,
                        height: 1,
                      ),
                    ),
                    Text(
                      'CRM SUITE',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryColor,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildSectionHeader('GENERAL'),
                _buildNavItem(Icons.grid_view_rounded, 'Dashboard', SidebarItem.dashboard),
                _buildNavItem(Icons.rocket_launch_rounded, 'Data Capture', SidebarItem.dataCapture),
                _buildNavItem(Icons.contact_phone_rounded, 'My Leads', SidebarItem.myLeads),
                
                const SizedBox(height: 32),
                _buildSectionHeader('WORKFLOW'),
                _buildNavItem(Icons.description_rounded, 'Proposals', SidebarItem.proposals),
                _buildNavItem(Icons.groups_rounded, 'Customers', SidebarItem.customers),
                _buildNavItem(Icons.folder_copy_rounded, 'Projects', SidebarItem.projects),
                
                const SizedBox(height: 32),
                _buildSectionHeader('INTELLIGENCE'),
                _buildNavItem(Icons.auto_awesome_rounded, 'AI Generator', SidebarItem.aiGenerator),
                _buildNavItem(Icons.hub_rounded, 'SMM Workflow', SidebarItem.smmWorkflow),
                _buildNavItem(Icons.send_rounded, 'AI Publisher', SidebarItem.aiPublisher),
                
                const SizedBox(height: 32),
                _buildSectionHeader('SYSTEM'),
                _buildNavItem(Icons.fingerprint_rounded, 'Attendance', SidebarItem.attendance),
                _buildNavItem(Icons.settings_suggest_rounded, 'Settings', SidebarItem.settings),
              ],
            ),
          ),

          // User Profile Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppTheme.borderSide.withValues(alpha: 0.5))),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2), width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppTheme.dashboardBg,
                        child: Text('AM', style: TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Avinash Magar',
                            style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                          ),
                          Text(
                            'Root Admin',
                            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildLogoutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, bottom: 16),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: AppTheme.textSecondary.withValues(alpha: 0.5),
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, SidebarItem item) {
    final bool isActive = currentSelection == item;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onItemSelected(item),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isActive ? AppTheme.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isActive ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ] : [],
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isActive ? Colors.white : AppTheme.textSecondary,
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: isActive ? Colors.white : AppTheme.textPrimary,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
                if (isActive) ...[
                  const Spacer(),
                  const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 18),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onLogout,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.power_settings_new_rounded, size: 18, color: Colors.red[600]),
              const SizedBox(width: 10),
              Text(
                'Sign Out',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.red[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
