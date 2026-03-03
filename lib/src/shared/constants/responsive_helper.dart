// lib/src/shared/utils/responsive_helper.dart
// ─────────────────────────────────────────────────────────────────────────────
//  Responsive breakpoints + layout helpers for MediAssure
//  Usage:
//    ResponsiveHelper.isMobile(context)   → true  if width < 600
//    ResponsiveHelper.isTablet(context)   → true  if 600 ≤ width < 1024
//    ResponsiveHelper.isDesktop(context)  → true  if width ≥ 1024
//
//    ResponsiveHelper.value(context, mobile: x, tablet: y, desktop: z)
//    → returns the right value for the current breakpoint
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class ResponsiveHelper {
  // ── Breakpoints ────────────────────────────────────────────
  static const double mobileBreakpoint  = 600;
  static const double tabletBreakpoint  = 1024;

  // ── Checks ─────────────────────────────────────────────────
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobileBreakpoint && w < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  // ── Value picker ───────────────────────────────────────────
  static T value<T>(
      BuildContext context, {
        required T mobile,
        T? tablet,
        required T desktop,
      }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context))  return tablet ?? desktop;
    return mobile;
  }

  // ── Convenience getters ────────────────────────────────────
  /// Sidebar should be shown inline (not in a drawer)
  static bool showSidebarInline(BuildContext context) =>
      isDesktop(context);

  /// Compact sidebar (icon only) for tablet
  static bool showCompactSidebar(BuildContext context) =>
      isTablet(context);

  /// Horizontal padding for page content
  static double pagePadding(BuildContext context) =>
      value(context, mobile: 16, tablet: 24, desktop: 32);

  /// Card column count for grid layouts
  static int cardColumns(BuildContext context) =>
      value(context, mobile: 1, tablet: 2, desktop: 3);
}

// ─────────────────────────────────────────────────────────────────────────────
//  ResponsiveLayout — Convenience widget
// ─────────────────────────────────────────────────────────────────────────────
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context)) return desktop;
    if (ResponsiveHelper.isTablet(context))  return tablet ?? desktop;
    return mobile;
  }
}