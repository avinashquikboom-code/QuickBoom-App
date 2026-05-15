import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/sidebar.dart';
import '../core/constants.dart';
import '../core/providers.dart';
import '../core/theme.dart';
import 'sidebar_views/dashboard_content_view.dart';
import 'sidebar_views/data_capture_view.dart';
import 'sidebar_views/my_leads_view.dart';
import 'notifications_view.dart';
import 'auth/login_view.dart';
import 'sidebar_views/attendance_view.dart';
import 'sidebar_views/other_views.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 1100;
    final bool isMobile = size.width <= 700;
    final currentSelection = ref.watch(sidebarSelectionProvider);
    final currentView = _buildCurrentView(currentSelection);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.white.withValues(alpha: 0.8),
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(color: Colors.transparent),
                ),
              ),
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu_rounded, color: AppTheme.textPrimary),
                );
              }),
              title: Text(
                _getAppBarTitle(currentSelection),
                style: GoogleFonts.outfit(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
              actions: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.flash_on_rounded, color: AppTheme.primaryColor, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationsView()),
                    );
                  },
                  icon: const Icon(Icons.notifications_none_rounded, color: AppTheme.textPrimary),
                ),
                const SizedBox(width: 8),
              ],
            )
          : null,
      drawer: isMobile
          ? Drawer(
              width: 280,
              child: Sidebar(
                currentSelection: currentSelection,
                onItemSelected: (item) {
                  ref.read(sidebarSelectionProvider.notifier).select(item);
                  Navigator.pop(context);
                },
                onLogout: () => _handleLogout(context),
              ),
            )
          : null,
      body: Row(
        children: [
          if (isDesktop)
            Sidebar(
              currentSelection: currentSelection,
              onItemSelected: (item) {
                ref.read(sidebarSelectionProvider.notifier).select(item);
              },
              onLogout: () => _handleLogout(context),
            ),
          Expanded(
            child: Container(
              color: AppTheme.dashboardBg,
              child: SafeArea(
                top: !isMobile,
                bottom: false,
                child: currentView,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: NavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                height: 65,
                selectedIndex: _getBottomNavIndex(currentSelection),
                onDestinationSelected: (index) {
                  ref.read(sidebarSelectionProvider.notifier).select(_getItemFromIndex(index));
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.dashboard_outlined),
                    selectedIcon: Icon(Icons.dashboard_rounded, color: AppTheme.primaryColor),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.people_outline_rounded),
                    selectedIcon: Icon(Icons.people_rounded, color: AppTheme.primaryColor),
                    label: 'Leads',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.add_circle_outline_rounded),
                    selectedIcon: Icon(Icons.add_circle_rounded, color: AppTheme.primaryColor),
                    label: 'Capture',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.fingerprint_rounded),
                    selectedIcon: Icon(Icons.fingerprint_rounded, color: AppTheme.primaryColor),
                    label: 'Attendance',
                  ),
                ],
              ),
            )
          : null,
    );
  }

  int _getBottomNavIndex(SidebarItem item) {
    switch (item) {
      case SidebarItem.dashboard: return 0;
      case SidebarItem.myLeads: return 1;
      case SidebarItem.dataCapture: return 2;
      case SidebarItem.attendance: return 3;
      default: return 0;
    }
  }

  SidebarItem _getItemFromIndex(int index) {
    switch (index) {
      case 0: return SidebarItem.dashboard;
      case 1: return SidebarItem.myLeads;
      case 2: return SidebarItem.dataCapture;
      case 3: return SidebarItem.attendance;
      default: return SidebarItem.dashboard;
    }
  }

  Widget _buildCurrentView(SidebarItem item) {
    return Container(
      key: ValueKey(item),
      child: _getViewForSelection(item),
    );
  }

  Widget _getViewForSelection(SidebarItem item) {
    switch (item) {
      case SidebarItem.dashboard:
        return const DashboardContentView();
      case SidebarItem.dataCapture:
        return const DataCaptureView();
      case SidebarItem.myLeads:
        return const MyLeadsView();
      case SidebarItem.attendance:
        return const AttendanceView();
      case SidebarItem.proposals:
        return const ProposalsView();
      case SidebarItem.customers:
        return const CustomersView();
      case SidebarItem.projects:
        return const ProjectsView();
      case SidebarItem.aiGenerator:
        return const AIGeneratorView();
      case SidebarItem.settings:
        return const SettingsView();
      default:
        return const DashboardContentView();
    }
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to logout from your session?', style: GoogleFonts.outfit()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.outfit(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Logout', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle(SidebarItem item) {
    switch (item) {
      case SidebarItem.dashboard:
        return 'Dashboard';
      case SidebarItem.dataCapture:
        return 'Data Capture';
      case SidebarItem.myLeads:
        return 'My Leads';
      case SidebarItem.proposals:
        return 'Proposals';
      case SidebarItem.customers:
        return 'Customers';
      case SidebarItem.projects:
        return 'Projects';
      case SidebarItem.aiGenerator:
        return 'AI Generator';
      case SidebarItem.smmWorkflow:
        return 'SMM Workflow';
      case SidebarItem.aiPublisher:
        return 'AI Publisher';
      case SidebarItem.attendance:
        return 'Attendance';
      case SidebarItem.settings:
        return 'Settings';
      default:
        return 'Quik Boom';
    }
  }
}
