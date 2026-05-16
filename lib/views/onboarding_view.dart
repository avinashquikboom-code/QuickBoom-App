import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import 'auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: 'Smart Lead Management',
      description: 'Track and nurture your leads with our intelligent automation suite. Never miss a conversion.',
      icon: Icons.auto_graph_rounded,
      color: AppTheme.accentColor,
    ),
    OnboardingContent(
      title: 'Real-time Analytics',
      description: 'Get deep insights into your business performance with live dashboards and detailed reports.',
      icon: Icons.analytics_rounded,
      color: AppTheme.warningColor,
    ),
    OnboardingContent(
      title: 'Team Collaboration',
      description: 'Empower your team with shared workflows, instant notifications, and project tracking.',
      icon: Icons.group_work_rounded,
      color: AppTheme.primaryColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => _navigateToLogin(),
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _contents.length,
                itemBuilder: (context, index) {
                  return _buildPage(_contents[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      _contents.length,
                      (index) => _buildIndicator(index),
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _contents.length - 1) {
                          _navigateToLogin();
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOutCubic,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _currentPage == _contents.length - 1 ? 'Get Started' : 'Next',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ).animate(key: ValueKey(_currentPage)).scale(duration: 300.ms),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingContent content) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: content.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              content.icon,
              size: 100,
              color: content.color,
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack).fadeIn(),
          const SizedBox(height: 60),
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
              height: 1.2,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
          const SizedBox(height: 16),
          Text(
            content.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: AppTheme.textSecondary,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    final bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
