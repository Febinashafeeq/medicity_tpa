import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class AppTheme {
//
//   static const Color primaryGold = Color(0xFF0B833D);
//   static const Color surfaceWhite = Color(0xFFF8F9FA);
//   static const Color textDark = Color(0xFF212529);
//
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       colorSchemeSeed: primaryGold,
//       brightness: Brightness.light,
//       scaffoldBackgroundColor: surfaceWhite,
//
//
//       fontFamily: 'Inter',
//
//       // Clean Button Styles
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           elevation: 0,
//           backgroundColor: primaryGold,
//           foregroundColor: Colors.white,
//           minimumSize: const Size(120, 48),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade200),
//         ),
//       ),
//
//       cardTheme: CardThemeData(
//         elevation: 0.5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//           side: BorderSide(color: Colors.grey.shade100),
//         ),
//       ),
//     );
//   }
// }


class AppTheme {
  // ── Brand Colors ──────────────────────────────────────
  static const Color primaryGreen      = Color(0xFF0B833D);
  static const Color primaryGreenDark  = Color(0xFF076B30);
  static const Color primaryGreenLight = Color(0xFFE8F5EE);

  static const Color surfaceWhite = Color(0xFFF8F9FA);
  static const Color cardWhite    = Color(0xFFFFFFFF);

  static const Color textDark  = Color(0xFF212529);
  static const Color textMid   = Color(0xFF495057);
  static const Color textLight = Color(0xFFADB5BD);

  static const Color borderColor   = Color(0xFFE9ECEF);
  static const Color borderLight   = Color(0xFFF1F3F5);

  static const Color errorRed      = Color(0xFFE53E3E);
  static const Color warningOrange = Color(0xFFDD6B20);
  static const Color infoBlue      = Color(0xFF1565C0);
  static const Color successGreen  = Color(0xFF0B833D);
  static const Color pendingAmber  = Color(0xFFF5A623);

  // ── Shadows ───────────────────────────────────────────
  static List<BoxShadow> get shadowSm => [
    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 2, offset: const Offset(0, 1)),
    BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 3, offset: const Offset(0, 1)),
  ];

  static List<BoxShadow> get shadowMd => [
    BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 24, offset: const Offset(0, 4)),
    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4,  offset: const Offset(0, 1)),
  ];

  static List<BoxShadow> get shadowGreen => [
    BoxShadow(color: primaryGreen.withOpacity(0.30), blurRadius: 16, offset: const Offset(0, 4)),
  ];

  // ── Theme ─────────────────────────────────────────────
  static ThemeData get lightTheme {
    final base = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primaryGreen,
      brightness: Brightness.light,
      scaffoldBackgroundColor: surfaceWhite,
      textTheme: base.copyWith(
        displayLarge:  base.displayLarge?.copyWith(fontWeight: FontWeight.w800, color: textDark),
        headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w700, color: textDark),
        headlineMedium:base.headlineMedium?.copyWith(fontWeight: FontWeight.w700, color: textDark),
        headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: textDark),
        titleLarge:    base.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: textDark),
        titleMedium:   base.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: textDark),
        titleSmall:    base.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: textMid),
        bodyLarge:     base.bodyLarge?.copyWith(fontWeight: FontWeight.w400, color: textMid),
        bodyMedium:    base.bodyMedium?.copyWith(fontWeight: FontWeight.w400, color: textMid),
        bodySmall:     base.bodySmall?.copyWith(fontWeight: FontWeight.w400, color: textLight),
        labelLarge:    base.labelLarge?.copyWith(fontWeight: FontWeight.w600, color: textDark),
        labelMedium:   base.labelMedium?.copyWith(fontWeight: FontWeight.w600, color: textMid),
        labelSmall:    base.labelSmall?.copyWith(fontWeight: FontWeight.w500, color: textLight, letterSpacing: 0.8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
          shadowColor: primaryGreen.withOpacity(0.3),
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) return 4;
            return 0;
          }),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: const BorderSide(color: primaryGreen, width: 1.5),
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        hintStyle: GoogleFonts.inter(color: textLight, fontSize: 14, fontWeight: FontWeight.w400),
        labelStyle: GoogleFonts.inter(color: textMid, fontSize: 13, fontWeight: FontWeight.w600),
        errorStyle: GoogleFonts.inter(color: errorRed, fontSize: 12, fontWeight: FontWeight.w500),
        prefixIconColor: textLight,
        suffixIconColor: textLight,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: cardWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderLight, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(color: borderColor, thickness: 1),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceWhite,
        labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}