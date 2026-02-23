import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/tpa_provider.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';

// ════════════════════════════════════════════════════════════
//  MAIN SHELL  (wraps all screens inside sidebar layout)
// ════════════════════════════════════════════════════════════
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        const _Sidebar(),
        const VerticalDivider(width: 1, thickness: 1, color: AppColors.border),
        Expanded(child: child),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  SIDEBAR
// ════════════════════════════════════════════════════════════
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    // Read badge counts from provider (no listen needed for location)
    final p        = context.watch<TpaProvider>();
    final location = GoRouterState.of(context).matchedLocation;

    return Container(
      width: 240,
      color: AppColors.white,
      child: Column(children: [
        // ── Logo ──────────────────────────────────────────────
        const _SidebarLogo(),

        // ── Nav items ─────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NavItem(
                  icon: Icons.dashboard_rounded,
                  label: 'Dashboard',
                  route: AppRoutes.dashboard,
                  location: location,
                ),

                const _SectionLabel('LEDGER MANAGEMENT'),

                _NavItem(
                  icon: Icons.business_rounded,
                  label: 'TPA Management',
                  route: AppRoutes.tpaList,
                  location: location,
                ),

                const _SectionLabel('DAILY OPERATIONS'),

                _NavItem(
                  icon: Icons.biotech_rounded,
                  label: 'Sample Collections',
                  route: AppRoutes.collectionList,
                  location: location,
                  badgeCount: p.todayCollections,
                ),
                _NavItem(
                  icon: Icons.pending_actions_rounded,
                  label: 'Pending Payments',
                  route: AppRoutes.collectionList,
                  location: location,
                  badgeCount: p.pendingPayments,
                  badgeDanger: true,
                ),

                const _SectionLabel('FINANCIAL'),

                _NavItem(
                  icon: Icons.receipt_long_rounded,
                  label: 'Invoice Ledger',
                  route: AppRoutes.invoiceLedger,
                  location: location,
                ),
                _NavItem(
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'Settlements',
                  route: AppRoutes.settlements,
                  location: location,
                ),
                _NavItem(
                  icon: Icons.bar_chart_rounded,
                  label: 'Reports & Analytics',
                  route: AppRoutes.reports,
                  location: location,
                ),
              ],
            ),
          ),
        ),

        // ── Footer ────────────────────────────────────────────
        const _SidebarFooter(),
      ]),
    );
  }
}

// ── Logo ─────────────────────────────────────────────────────────────────────
class _SidebarLogo extends StatelessWidget {
  const _SidebarLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border, width: 1))),
      child: Row(children: [
        Container(
          width: 34, height: 34,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(9)),
          child: const Icon(Icons.health_and_safety_rounded,
              color: Colors.white, size: 18),
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

// ── Section label ─────────────────────────────────────────────────────────────
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

// ── Nav item ──────────────────────────────────────────────────────────────────
// NOTE: Hover needs local state — everything else is stateless/provider.
class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String route;
  final String location;
  final String? matchPrefix;
  final int badgeCount;
  final bool badgeDanger;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.location,
    this.matchPrefix,
    this.badgeCount = 0,
    this.badgeDanger = false,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  bool get _isActive {
    final match = widget.matchPrefix ?? widget.route;
    if (match == AppRoutes.dashboard) return widget.location == AppRoutes.dashboard;
    return widget.location.startsWith(match);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => context.go(widget.route),
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
              Icon(widget.icon,
                  size: 17,
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

// ── Sidebar Footer ────────────────────────────────────────────────────────────
class _SidebarFooter extends StatelessWidget {
  const _SidebarFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 1))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary,
            child: Text('A',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('TPA Admin',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                Text('Admin Name',
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, size: 16, color: AppColors.textLight),
            onPressed: () => context.go(AppRoutes.login),
            tooltip: 'Logout',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ]),
      ),
    );
  }
}