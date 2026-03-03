import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/tpa_provider.dart';
import '../constants/responsive_helper.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';

// // ════════════════════════════════════════════════════════════
// //  MAIN SHELL  (wraps all screens inside sidebar layout)
// // ════════════════════════════════════════════════════════════
// class MainShell extends StatelessWidget {
//   final Widget child;
//   const MainShell({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(children: [
//         const _Sidebar(),
//         const VerticalDivider(width: 1, thickness: 1, color: AppColors.border),
//         Expanded(child: child),
//       ]),
//     );
//   }
// }
//
// // ════════════════════════════════════════════════════════════
// //  SIDEBAR
// // ════════════════════════════════════════════════════════════
// class _Sidebar extends StatelessWidget {
//   const _Sidebar();
//
//   @override
//   Widget build(BuildContext context) {
//     // Read badge counts from provider (no listen needed for location)
//     final p        = context.watch<TpaProvider>();
//     final location = GoRouterState.of(context).matchedLocation;
//
//     return Container(
//       width: 240,
//       color: AppColors.white,
//       child: Column(children: [
//         // ── Logo ──────────────────────────────────────────────
//         const _SidebarLogo(),
//
//         // ── Nav items ─────────────────────────────────────────
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _NavItem(
//                   icon: Icons.dashboard_rounded,
//                   label: 'Dashboard',
//                   route: AppRoutes.dashboard,
//                   location: location,
//                 ),
//
//                 const _SectionLabel('LEDGER MANAGEMENT'),
//
//                 _NavItem(
//                   icon: Icons.business_rounded,
//                   label: 'TPA Management',
//                   route: AppRoutes.tpaList,
//                   location: location,
//                 ),
//
//                 const _SectionLabel('DAILY OPERATIONS'),
//
//                 _NavItem(
//                   icon: Icons.biotech_rounded,
//                   label: 'Sample Collections',
//                   route: AppRoutes.collectionList,
//                   location: location,
//                   badgeCount: p.todayCollections,
//                 ),
//                 _NavItem(
//                   icon: Icons.pending_actions_rounded,
//                   label: 'Pending Payments',
//                   route: AppRoutes.collectionList,
//                   location: location,
//                   badgeCount: p.pendingPayments,
//                   badgeDanger: true,
//                 ),
//
//                 const _SectionLabel('FINANCIAL'),
//
//                 _NavItem(
//                   icon: Icons.receipt_long_rounded,
//                   label: 'Invoice Ledger',
//                   route: AppRoutes.invoiceLedger,
//                   location: location,
//                 ),
//                 _NavItem(
//                   icon: Icons.account_balance_wallet_rounded,
//                   label: 'Settlements',
//                   route: AppRoutes.settlements,
//                   location: location,
//                 ),
//                 _NavItem(
//                   icon: Icons.bar_chart_rounded,
//                   label: 'Reports & Analytics',
//                   route: AppRoutes.reports,
//                   location: location,
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         // ── Footer ────────────────────────────────────────────
//         const _SidebarFooter(),
//       ]),
//     );
//   }
// }
//
// // ── Logo ─────────────────────────────────────────────────────────────────────
// class _SidebarLogo extends StatelessWidget {
//   const _SidebarLogo();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 64,
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: const BoxDecoration(
//           border: Border(bottom: BorderSide(color: AppColors.border, width: 1))),
//       child: Row(children: [
//         Container(
//           width: 34, height: 34,
//           decoration: BoxDecoration(
//               color: AppColors.primary,
//               borderRadius: BorderRadius.circular(9)),
//           child: const Icon(Icons.health_and_safety_rounded,
//               color: Colors.white, size: 18),
//         ),
//         const SizedBox(width: 10),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('MediAssure',
//                 style: GoogleFonts.inter(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w800,
//                     color: AppColors.textDark,
//                     letterSpacing: -0.3)),
//             Text('TPA Ledger System',
//                 style: GoogleFonts.inter(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textLight)),
//           ],
//         ),
//       ]),
//     );
//   }
// }
//
// // ── Section label ─────────────────────────────────────────────────────────────
// class _SectionLabel extends StatelessWidget {
//   final String text;
//   const _SectionLabel(this.text);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
//       child: Text(text,
//           style: GoogleFonts.inter(
//               fontSize: 10,
//               fontWeight: FontWeight.w700,
//               color: AppColors.textLight,
//               letterSpacing: 1.2)),
//     );
//   }
// }
//
// // ── Nav item ──────────────────────────────────────────────────────────────────
// // NOTE: Hover needs local state — everything else is stateless/provider.
// class _NavItem extends StatefulWidget {
//   final IconData icon;
//   final String label;
//   final String route;
//   final String location;
//   final String? matchPrefix;
//   final int badgeCount;
//   final bool badgeDanger;
//
//   const _NavItem({
//     required this.icon,
//     required this.label,
//     required this.route,
//     required this.location,
//     this.matchPrefix,
//     this.badgeCount = 0,
//     this.badgeDanger = false,
//   });
//
//   @override
//   State<_NavItem> createState() => _NavItemState();
// }
//
// class _NavItemState extends State<_NavItem> {
//   bool _hovered = false;
//
//   bool get _isActive {
//     final match = widget.matchPrefix ?? widget.route;
//     if (match == AppRoutes.dashboard) return widget.location == AppRoutes.dashboard;
//     return widget.location.startsWith(match);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
//       child: MouseRegion(
//         onEnter: (_) => setState(() => _hovered = true),
//         onExit:  (_) => setState(() => _hovered = false),
//         child: GestureDetector(
//           onTap: () => context.go(widget.route),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 150),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
//             decoration: BoxDecoration(
//               color: _isActive
//                   ? AppColors.primaryLight
//                   : _hovered
//                   ? const Color(0xFFF8F9FA)
//                   : Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(children: [
//               Icon(widget.icon,
//                   size: 17,
//                   color: _isActive ? AppColors.primary : AppColors.textMid),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Text(widget.label,
//                     style: GoogleFonts.inter(
//                         fontSize: 13,
//                         fontWeight: _isActive ? FontWeight.w600 : FontWeight.w500,
//                         color: _isActive ? AppColors.primary : AppColors.textMid)),
//               ),
//               if (widget.badgeCount > 0)
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: widget.badgeDanger ? AppColors.error : AppColors.primary,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text('${widget.badgeCount}',
//                       style: GoogleFonts.inter(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white)),
//                 ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ── Sidebar Footer ────────────────────────────────────────────────────────────
// class _SidebarFooter extends StatelessWidget {
//   const _SidebarFooter();
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 90,
//       child: FutureBuilder<SharedPreferences>(
//         future: SharedPreferences.getInstance(),
//         builder: (context, snapshot) {
//
//           // ⏳ Loading
//           if (snapshot.connectionState != ConnectionState.done) {
//             return const SizedBox(
//               height: 60,
//               child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
//             );
//           }
//
//           // ❌ Error or no data
//           if (!snapshot.hasData) {
//             return const SizedBox();
//           }
//
//           final prefs = snapshot.data!;
//           final name  = prefs.getString('adminName') ?? 'Admin';
//           final email = prefs.getString('adminEmail') ?? '';
//
//           return Container(
//             padding: const EdgeInsets.all(12),
//             decoration: const BoxDecoration(
//               border: Border(top: BorderSide(color: AppColors.border)),
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundColor: AppColors.primary,
//                   child: Text(
//                     name.isNotEmpty ? name[0].toUpperCase() : 'A',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         name,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         email,
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.logout_rounded, size: 16),
//                   tooltip: 'Logout',
//                   onPressed: () async {
//                     await FirebaseAuth.instance.signOut();
//                     await prefs.clear();
//                     context.go(AppRoutes.login);
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// Future<void> _logout(BuildContext context) async {
//   await FirebaseAuth.instance.signOut();
//   context.go(AppRoutes.login);
// }

/// changed for responsive
// lib/src/shared/widgets/main_shell.dart
// ─────────────────────────────────────────────────────────────────────────────
//  RESPONSIVE MAIN SHELL
//  • Desktop  (≥1024px) : permanent inline sidebar  (240 px)
//  • Tablet   (600-1023): compact icon-rail sidebar  (68 px) + tap-to-expand drawer
//  • Mobile   (<600px)  : no sidebar — hamburger → full-width bottom-sheet drawer
// ─────────────────────────────────────────────────────────────────────────────


// ════════════════════════════════════════════════════════════
//  MAIN SHELL
// ════════════════════════════════════════════════════════════
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // ── Desktop: classic sidebar + content ──────────────────
    if (ResponsiveHelper.isDesktop(context)) {
      return Scaffold(
        body: Row(children: [
          const _DesktopSidebar(),
          const VerticalDivider(width: 1, thickness: 1, color: AppColors.border),
          Expanded(child: child),
        ]),
      );
    }

    // ── Tablet: compact rail + drawer overlay ────────────────
    if (ResponsiveHelper.isTablet(context)) {
      return Scaffold(
        drawer: const _DrawerSidebar(),
        body: Row(children: [
          const _TabletRail(),
          const VerticalDivider(width: 1, thickness: 1, color: AppColors.border),
          Expanded(child: child),
        ]),
      );
    }

    // ── Mobile: top AppBar + drawer ──────────────────────────
    return Scaffold(
      drawer: const _DrawerSidebar(),
      appBar: _MobileAppBar(),
      body: child,
    );
  }
}

// ════════════════════════════════════════════════════════════
//  MOBILE APP BAR
// ════════════════════════════════════════════════════════════
class _MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: AppColors.white,
      shadowColor: Colors.black.withOpacity(0.08),
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.textDark, size: 22),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      title: Row(children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Icon(Icons.health_and_safety_rounded, color: Colors.white, size: 15),
        ),
        const SizedBox(width: 8),
        Text(
          'MediAssure',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
            letterSpacing: -0.3,
          ),
        ),
      ]),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppColors.border, height: 1),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  DESKTOP SIDEBAR  (unchanged visual design)
// ════════════════════════════════════════════════════════════
class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar();

  @override
  Widget build(BuildContext context) {
    final p        = context.watch<TpaProvider>();
    final location = GoRouterState.of(context).matchedLocation;

    return Container(
      width: 240,
      color: AppColors.white,
      child: Column(children: [
        _SidebarLogo(compact: false),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _NavItems(
              location: location,
              todayCollections: p.todayCollections,
              pendingPayments: p.pendingPayments,
              compact: false,
            ),
          ),
        ),
        const _SidebarFooter(compact: false),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  TABLET RAIL  (icon-only, 68 px wide)
// ════════════════════════════════════════════════════════════
class _TabletRail extends StatelessWidget {
  const _TabletRail();

  @override
  Widget build(BuildContext context) {
    final p        = context.watch<TpaProvider>();
    final location = GoRouterState.of(context).matchedLocation;

    return Container(
      width: 68,
      color: AppColors.white,
      child: Column(children: [
        // ── Logo icon ────────────────────────────────────────
        _SidebarLogo(compact: true),

        // ── Hamburger to open full drawer ────────────────────
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Builder(
            builder: (ctx) => _RailIcon(
              icon: Icons.menu_rounded,
              label: 'Menu',
              active: false,
              onTap: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
        ),

        const _RailDivider(),

        // ── Rail nav icons ────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _NavItems(
              location: location,
              todayCollections: p.todayCollections,
              pendingPayments: p.pendingPayments,
              compact: true,
            ),
          ),
        ),

        const _SidebarFooter(compact: true),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  DRAWER SIDEBAR  (mobile full / tablet full via hamburger)
// ════════════════════════════════════════════════════════════
class _DrawerSidebar extends StatelessWidget {
  const _DrawerSidebar();

  @override
  Widget build(BuildContext context) {
    final p        = context.watch<TpaProvider>();
    final location = GoRouterState.of(context).matchedLocation;

    return Drawer(
      width: 260,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: Column(children: [
        _SidebarLogo(compact: false),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _NavItems(
              location: location,
              todayCollections: p.todayCollections,
              pendingPayments: p.pendingPayments,
              compact: false,
              closeDrawerOnTap: true,
            ),
          ),
        ),
        const _SidebarFooter(compact: false),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  SHARED: Logo
// ════════════════════════════════════════════════════════════
class _SidebarLogo extends StatelessWidget {
  final bool compact;
  const _SidebarLogo({required this.compact});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: compact
          ? Center(
        child: Container(
          width: 34, height: 34,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Icon(Icons.health_and_safety_rounded, color: Colors.white, size: 18),
        ),
      )
          : Row(children: [
        Container(
          width: 34, height: 34,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Icon(Icons.health_and_safety_rounded, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MediAssure',
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    letterSpacing: -0.3)),
            Text('TPA Ledger System',
                style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textLight)),
          ],
        ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  SHARED: Nav Items
// ════════════════════════════════════════════════════════════
class _NavItems extends StatelessWidget {
  final String location;
  final int todayCollections;
  final int pendingPayments;
  final bool compact;
  final bool closeDrawerOnTap;

  const _NavItems({
    required this.location,
    required this.todayCollections,
    required this.pendingPayments,
    required this.compact,
    this.closeDrawerOnTap = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      // Tablet rail: icons only
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _RailIcon(icon: Icons.dashboard_rounded,           label: 'Dashboard',         active: location == AppRoutes.dashboard,          onTap: () => context.go(AppRoutes.dashboard)),
          _RailIcon(icon: Icons.business_rounded,            label: 'TPA',               active: location.startsWith(AppRoutes.tpaList),  onTap: () => context.go(AppRoutes.tpaList)),
          const _RailDivider(),
          _RailIcon(icon: Icons.biotech_rounded,             label: 'Collections',       active: location.startsWith(AppRoutes.collectionList), onTap: () => context.go(AppRoutes.collectionList), badge: todayCollections),
          _RailIcon(icon: Icons.pending_actions_rounded,     label: 'Payments',          active: false,                                   onTap: () => context.go(AppRoutes.collectionList), badge: pendingPayments, badgeDanger: true),
          const _RailDivider(),
          _RailIcon(icon: Icons.receipt_long_rounded,        label: 'Invoices',          active: location.startsWith(AppRoutes.invoiceLedger), onTap: () => context.go(AppRoutes.invoiceLedger)),
          _RailIcon(icon: Icons.account_balance_wallet_rounded, label: 'Settlements',   active: location.startsWith(AppRoutes.settlements),  onTap: () => context.go(AppRoutes.settlements)),
          _RailIcon(icon: Icons.bar_chart_rounded,           label: 'Reports',           active: location.startsWith(AppRoutes.reports),  onTap: () => context.go(AppRoutes.reports)),
        ],
      );
    }

    // Full sidebar labels
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NavItem(icon: Icons.dashboard_rounded,              label: 'Dashboard',         route: AppRoutes.dashboard,      location: location, closeDrawerOnTap: closeDrawerOnTap),
        const _SectionLabel('LEDGER MANAGEMENT'),
        _NavItem(icon: Icons.business_rounded,               label: 'TPA Management',    route: AppRoutes.tpaList,         location: location, closeDrawerOnTap: closeDrawerOnTap),
        const _SectionLabel('DAILY OPERATIONS'),
        _NavItem(icon: Icons.biotech_rounded,                label: 'Sample Collections', route: AppRoutes.collectionList, location: location, badgeCount: todayCollections, closeDrawerOnTap: closeDrawerOnTap),
        _NavItem(icon: Icons.pending_actions_rounded,        label: 'Pending Payments',   route: AppRoutes.collectionList, location: location, badgeCount: pendingPayments, badgeDanger: true, closeDrawerOnTap: closeDrawerOnTap),
        const _SectionLabel('FINANCIAL'),
        _NavItem(icon: Icons.receipt_long_rounded,           label: 'Invoice Ledger',     route: AppRoutes.invoiceLedger,  location: location, closeDrawerOnTap: closeDrawerOnTap),
        _NavItem(icon: Icons.account_balance_wallet_rounded, label: 'Settlements',        route: AppRoutes.settlements,    location: location, closeDrawerOnTap: closeDrawerOnTap),
        _NavItem(icon: Icons.bar_chart_rounded,              label: 'Reports & Analytics', route: AppRoutes.reports,       location: location, closeDrawerOnTap: closeDrawerOnTap),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════
//  Tablet Rail Icon
// ════════════════════════════════════════════════════════════
class _RailIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  final int badge;
  final bool badgeDanger;

  const _RailIcon({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    this.badge = 0,
    this.badgeDanger = false,
  });

  @override
  State<_RailIcon> createState() => _RailIconState();
}

class _RailIconState extends State<_RailIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Tooltip(
        message: widget.label,
        preferBelow: false,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit:  (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: widget.active
                    ? AppColors.primaryLight
                    : _hovered
                    ? const Color(0xFFF8F9FA)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(widget.icon, size: 19,
                      color: widget.active ? AppColors.primary : AppColors.textMid),
                  if (widget.badge > 0)
                    Positioned(
                      top: 6, right: 6,
                      child: Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                          color: widget.badgeDanger ? AppColors.error : AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RailDivider extends StatelessWidget {
  const _RailDivider();
  @override
  Widget build(BuildContext context) =>
      Container(margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          height: 1, color: AppColors.border);
}

// ════════════════════════════════════════════════════════════
//  Section Label
// ════════════════════════════════════════════════════════════
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
      child: Text(text,
          style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textLight,
              letterSpacing: 1.2)),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  Nav Item (full label)
// ════════════════════════════════════════════════════════════
class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String route;
  final String location;
  final int badgeCount;
  final bool badgeDanger;
  final bool closeDrawerOnTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.location,
    this.badgeCount = 0,
    this.badgeDanger = false,
    this.closeDrawerOnTap = false,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  bool get _isActive {
    if (widget.route == AppRoutes.dashboard) return widget.location == AppRoutes.dashboard;
    return widget.location.startsWith(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () {
            if (widget.closeDrawerOnTap) Navigator.of(context).pop();
            context.go(widget.route);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              color: _isActive
                  ? AppColors.primaryLight
                  : _hovered
                  ? const Color(0xFFF8F9FA)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(children: [
              Icon(widget.icon, size: 17,
                  color: _isActive ? AppColors.primary : AppColors.textMid),
              const SizedBox(width: 10),
              Expanded(
                child: Text(widget.label,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: _isActive ? FontWeight.w600 : FontWeight.w500,
                        color: _isActive ? AppColors.primary : AppColors.textMid)),
              ),
              if (widget.badgeCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: widget.badgeDanger ? AppColors.error : AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${widget.badgeCount}',
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  Sidebar Footer
// ════════════════════════════════════════════════════════════
class _SidebarFooter extends StatelessWidget {
  final bool compact;
  const _SidebarFooter({required this.compact});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: compact ? 68 : 90,
      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          }
          if (!snapshot.hasData) return const SizedBox();

          final prefs = snapshot.data!;
          final name  = prefs.getString('adminName') ?? 'Admin';
          final email = prefs.getString('adminEmail') ?? '';

          Future<void> doLogout() async {
            await FirebaseAuth.instance.signOut();
            await prefs.clear();
            if (context.mounted) context.go(AppRoutes.login);
          }

          return Container(
            padding: EdgeInsets.all(compact ? 8 : 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: compact
            // ── Compact: avatar + logout stacked ──────────
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'A',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: doLogout,
                  child: const Icon(Icons.logout_rounded, size: 14, color: AppColors.textLight),
                ),
              ],
            )
            // ── Full: avatar + name + logout button ────────
                : Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'A',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(name,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(email,
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout_rounded, size: 16),
                  tooltip: 'Logout',
                  onPressed: doLogout,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}