import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // GhatSafe Color System
  static const Color primaryEmergency = Color(0xFFFF3B30);
  static const Color primaryWarning = Color(0xFFFF9500);
  static const Color primarySafe = Color(0xFF30D158);
  static const Color primaryInfo = Color(0xFF0A84FF);
  static const Color backgroundDark = Color(0xFF0A0A0F);
  static const Color surfaceGlass = Color(0x12FFFFFF);
  static const Color surfaceGlassVariant = Color(0x1FFFFFFF);
  static const Color glassBorder = Color(0x26FFFFFF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0x8CFFFFFF);
  static const Color cardSurface = Color(0x0FFFFFFF);
  static const Color dividerColor = Color(0x1AFFFFFF);

  // Semantic colors
  static const Color dangerRed = Color(0xFFFF3B30);
  static const Color warningAmber = Color(0xFFFF9500);
  static const Color safeGreen = Color(0xFF30D158);
  static const Color infoBlue = Color(0xFF0A84FF);
  static const Color authorityBlue = Color(0xFF007AFF);

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryEmergency,
      secondary: primaryWarning,
      tertiary: primarySafe,
      surface: Color(0xFF12121A),
      onSurface: textPrimary,
      outline: glassBorder,
      error: dangerRed,
    ),
    scaffoldBackgroundColor: backgroundDark,
    textTheme: GoogleFonts.ibmPlexSansTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textMuted,
        ),
        labelLarge: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    ),
    appBarTheme: const AppBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceGlass,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: glassBorder, width: 1),
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: surfaceGlass,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: glassBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: glassBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryInfo, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: dangerRed, width: 1),
      ),
      labelStyle: const TextStyle(color: textMuted, fontSize: 14),
      hintStyle: const TextStyle(color: textMuted, fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryEmergency,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    ),
    dividerTheme: const DividerThemeData(color: dividerColor, thickness: 1),
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryEmergency,
      secondary: primaryWarning,
      tertiary: primarySafe,
      surface: Colors.white,
      onSurface: const Color(0xFF1C1C1E),
      outline: Colors.grey.shade300,
      error: dangerRed,
    ),
    scaffoldBackgroundColor: const Color(0xFFF2F2F7),
    textTheme: GoogleFonts.ibmPlexSansTextTheme(),
    appBarTheme: const AppBarThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      iconTheme: IconThemeData(color: Color(0xFF1C1C1E)),
    ),
  );
}
