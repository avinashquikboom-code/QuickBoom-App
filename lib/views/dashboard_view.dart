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
              backgroundColor: Colors.white.withValues(alpha: 0.7),
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(color: Colors.transparent),
                ),
              ),
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.grid_view_rounded, color: AppTheme.textPrimary, size: 22),
                );
              }),
              title: Text(
                'Quik Boom',
                style: GoogleFonts.outfit(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: -0.5,
                ),
              ),
              centerTitle: true,
              actions: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationsView()),
                        );
                      },
                      icon: const Icon(Icons.notifications_outlined, color: AppTheme.textPrimary, size: 24),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
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
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 20,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: NavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                height: 70,
                indicatorColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                selectedIndex: _getBottomNavIndex(currentSelection),
                onDestinationSelected: (index) {
                  ref.read(sidebarSelectionProvider.notifier).select(_getItemFromIndex(index));
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.grid_view_rounded, color: AppTheme.textSecondary),
                    selectedIcon: Icon(Icons.grid_view_rounded, color: AppTheme.primaryColor),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.contact_phone_outlined, color: AppTheme.textSecondary),
                    selectedIcon: Icon(Icons.contact_phone_rounded, color: AppTheme.primaryColor),
                    label: 'Leads',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.rocket_launch_outlined, color: AppTheme.textSecondary),
                    selectedIcon: Icon(Icons.rocket_launch_rounded, color: AppTheme.primaryColor),
                    label: 'Data',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.fingerprint_rounded, color: AppTheme.textSecondary),
                    selectedIcon: Icon(Icons.fingerprint_rounded, color: AppTheme.primaryColor),
                    label: 'Access',
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
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text('Sign Out', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to end your current session?', style: GoogleFonts.outfit()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Stay logged in', style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontWeight: FontWeight.w600)),
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
                backgroundColor: AppTheme.errorColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Sign Out', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
