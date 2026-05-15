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
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Column(
        children: [
          // Logo Section
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.primaryColor.withValues(alpha: 0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 14),
                Text(
                  'Quik Boom',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildSectionHeader('MAIN MENU'),
                _buildNavItem(Icons.dashboard_rounded, 'Dashboard', SidebarItem.dashboard),
                _buildNavItem(Icons.data_usage_rounded, 'Data Capture', SidebarItem.dataCapture),
                _buildNavItem(Icons.people_alt_rounded, 'My Leads', SidebarItem.myLeads),
                
                const SizedBox(height: 24),
                _buildSectionHeader('OPERATIONS'),
                _buildNavItem(Icons.description_rounded, 'Proposals', SidebarItem.proposals),
                _buildNavItem(Icons.person_search_rounded, 'Customers', SidebarItem.customers),
                _buildNavItem(Icons.folder_rounded, 'Projects', SidebarItem.projects),
                
                const SizedBox(height: 24),
                _buildSectionHeader('AI SUITE'),
                _buildNavItem(Icons.auto_awesome_rounded, 'AI Generator', SidebarItem.aiGenerator),
                _buildNavItem(Icons.hub_rounded, 'SMM Workflow', SidebarItem.smmWorkflow),
                _buildNavItem(Icons.send_rounded, 'AI Publisher', SidebarItem.aiPublisher),
                
                const SizedBox(height: 24),
                _buildSectionHeader('INTERNAL'),
                _buildNavItem(Icons.fingerprint_rounded, 'Attendance', SidebarItem.attendance),
                _buildNavItem(Icons.settings_rounded, 'Settings', SidebarItem.settings),
              ],
            ),
          ),

          // User Profile Section
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50]!,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[100]!),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.orangeAccent,
                      child: Text('A', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Avinash Magar',
                            style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                          ),
                          Text(
                            'Administrator',
                            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
      padding: const EdgeInsets.only(left: 12, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey[400],
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, SidebarItem item) {
    final bool isActive = currentSelection == item;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onItemSelected(item),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? AppTheme.primaryColor.withValues(alpha: 0.08) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isActive ? Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.1)) : null,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isActive ? AppTheme.primaryColor : Colors.grey[500],
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: isActive ? AppTheme.primaryColor : AppTheme.textPrimary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                if (isActive) ...[
                  const Spacer(),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
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
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red[50]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, size: 16, color: Colors.red[400]),
              const SizedBox(width: 8),
              Text(
                'Logout Session',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: Colors.red[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
