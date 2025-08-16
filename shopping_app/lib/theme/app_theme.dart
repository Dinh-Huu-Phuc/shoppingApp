import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // TODO: thay các màu này bằng token từ Figma (Dev Mode → Inspect)
  static const primary = Color(0xFF111827); // Primary
  static const secondary = Color(0xFFEF4444); // Accent
  static const bg = Color(0xFFF9FAFB); // Background
  static const text = Color(0xFF111827);
  static const muted = Color(0xFF6B7280);
  static const radius = 16.0;

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);

    final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      displaySmall: GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.w700, color: text),
      headlineMedium: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: text),
      titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: text),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: text),
      bodySmall: GoogleFonts.inter(fontSize: 12, color: muted),
    );

    final colorScheme = base.colorScheme.copyWith(
      primary: primary,
      secondary: secondary,
      surface: Colors.white,
      background: bg,
      onPrimary: Colors.white,
      onSurface: text,
      onBackground: text,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: bg,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: textTheme.titleMedium,
        iconTheme: const IconThemeData(color: text),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: 0,
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}