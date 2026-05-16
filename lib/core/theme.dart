import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryColor = Color(0xFF22C55E); // Primary Green
  static const Color darkGreen = Color(0xFF16A34A); // Dark Green
  static const Color lightGreen = Color(0xFFDCFCE7); // Light Green
  static const Color accentColor = Color(0xFF3B82F6); // Blue Accent
  static const Color successColor = Color(0xFF16A34A); // Dark Green
  static const Color successBadge = Color(0xFFBBF7D0); // Success Badge
  static const Color successText = Color(0xFF15803D); // Success Text
  static const Color warningColor = Color(0xFFF59E0B); // Warning Orange
  static const Color errorColor = Color(0xFFEF4444); // Danger Red

  // Neutral Colors
  static const Color sidebarBg = Color(0xFFF8FAFC);
  static const Color mainBg = Color(0xFFFFFFFF);
  static const Color dashboardBg = Color(0xFFF8FAFC);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0F172A); // Primary Text
  static const Color textSecondary = Color(0xFF94A3B8); // Secondary Text
  static const Color borderSide = Color(0xFFE5E7EB); // Border

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        surface: mainBg,
        error: errorColor,
      ),
      scaffoldBackgroundColor: dashboardBg,
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        headlineLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 15,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 13,
          color: textSecondary,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderSide, width: 1),
        ),
      ),
    );
  }
}
