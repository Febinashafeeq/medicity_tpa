import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../services/tpa_provider.dart';
import '../../../shared/router/app_router.dart';
import '../../../shared/theme/app_colors.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


// ════════════════════════════════════════════════════════════
//  DASHBOARD SCREEN
// ════════════════════════════════════════════════════════════
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<TpaProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          const AppTopBar(title: 'Dashboard', breadcrumbs: ['Home']),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _WelcomeBar(),
                  const SizedBox(height: 24),
                  _label('Overview'),
                  const SizedBox(height: 12),
                  _SummaryCards(p: p),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _RecentCollections(p: p)),
                      const SizedBox(width: 20),
                      Expanded(flex: 2, child: _QuickActions()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark));
}

// ── Welcome Bar ───────────────────────────────────────────────────────────────
class _WelcomeBar extends StatelessWidget {
  String get _greeting {
    final h = DateTime.now().hour;
    return h < 12 ? 'Good Morning' : h < 17 ? 'Good Afternoon' : 'Good Evening';
  }

  String get _dateStr {
    final d = DateTime.now();
    final days   = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${days[d.weekday - 1]}, ${d.day} ${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B833D), Color(0xFF076B30)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$_greeting, Admin 👋',
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 4),
          Text(_dateStr,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.75))),
        ]),
      ]),
    );
  }
}

// ── Summary Cards ─────────────────────────────────────────────────────────────
class _SummaryCards extends StatelessWidget {
  final TpaProvider p;
  const _SummaryCards({required this.p});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        _StatCard(label: 'Total TPAs',       value: '${p.totalTpas}',   sub: '${p.activeTpas} Active',       icon: Icons.business_rounded,              color: AppColors.primary),
        const SizedBox(width: 14),
        _StatCard(label: 'Companies',        value: '${p.totalCompanies}', sub: 'Across all TPAs',            icon: Icons.verified_user_rounded,         color: const Color(0xFF1565C0)),
        const SizedBox(width: 14),
        _StatCard(label: 'Total Patients',   value: '${p.totalPatients}', sub: 'Registered members',         icon: Icons.people_rounded,                color: const Color(0xFF7B3F9E)),
        const SizedBox(width: 14),
        _StatCard(label: "Today's Collections", value: '${p.todayCollections}', sub: 'Samples collected',   icon: Icons.biotech_rounded,               color: const Color(0xFFDD6B20)),
      ]),
      const SizedBox(height: 14),
      Row(children: [
        _StatCard(label: 'Pending Payments', value: '${p.pendingPayments}',  sub: 'Awaiting invoice',       icon: Icons.pending_actions_rounded,       color: AppColors.error),
        const SizedBox(width: 14),
        _StatCard(label: "Today's Amount",   value: '₹${p.todayAmount.toStringAsFixed(0)}', sub: 'Billed today', icon: Icons.currency_rupee_rounded,  color: AppColors.primary),
        const SizedBox(width: 14),
        _StatCard(label: 'Total Received',   value: '₹${p.totalReceived.toStringAsFixed(0)}', sub: 'All time', icon: Icons.account_balance_wallet_rounded, color: const Color(0xFF1565C0)),
        const SizedBox(width: 14),
        _StatCard(label: 'Active TPAs',      value: '${p.activeTpas}',   sub: 'Out of ${p.totalTpas}',       icon: Icons.check_circle_rounded,          color: AppColors.primary),
      ]),
    ]);
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final IconData icon;
  final Color color;
  const _StatCard({required this.label, required this.value, required this.sub, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border)),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textMid)),
            const SizedBox(height: 2),
            Text(sub, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight)),
          ])),
        ]),
      ),
    );
  }
}

// ── Recent Collections ────────────────────────────────────────────────────────
class _RecentCollections extends StatelessWidget {
  final TpaProvider p;
  const _RecentCollections({required this.p});

  @override
  Widget build(BuildContext context) {
    final recent = p.allDailyCollections.take(6).toList();
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
          child: Row(children: [
            const Icon(Icons.biotech_rounded, size: 16, color: AppColors.primary),
            const SizedBox(width: 8),
            Text("Today's Collections",
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
            const Spacer(),
            TextButton(
              onPressed: () => context.go(AppRoutes.collectionList),
              child: Text('View All',
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
            ),
          ]),
        ),
        const Divider(height: 1, color: AppColors.border),
        if (recent.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(child: Text('No collections today', style: GoogleFonts.inter(color: AppColors.textLight))),
          )
        else
          ...recent.map((c) {
            final patient = p.patientById(c.patientId);
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                child: Row(children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primaryLight,
                    child: Text(patient.name[0],
                        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(patient.name,
                        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                    Text(c.tests,
                        style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight),
                        overflow: TextOverflow.ellipsis),
                  ])),
                  const SizedBox(width: 8),
                  Text('₹${c.amount.toStringAsFixed(0)}',
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                  const SizedBox(width: 8),
                  _PayBadge(paid: c.paymentReceived),
                ]),
              ),
              const Divider(height: 1, color: Color(0xFFF1F3F5)),
            ]);
          }),
      ]),
    );
  }
}

// ── Quick Actions ─────────────────────────────────────────────────────────────
class _QuickActions extends StatelessWidget {
  static const _actions = [
    (icon: Icons.business_rounded,              label: 'Manage TPAs',          sub: 'View & add TPAs',          route: AppRoutes.tpaList,        color: AppColors.primary),
    (icon: Icons.biotech_rounded,               label: 'Sample Collections',   sub: "Today's samples",          route: AppRoutes.collectionList, color: Color(0xFFDD6B20)),
    (icon: Icons.receipt_long_rounded,          label: 'Invoice Ledger',        sub: 'All invoices',             route: AppRoutes.invoiceLedger,  color: Color(0xFF1565C0)),
    (icon: Icons.account_balance_wallet_rounded,label: 'Settlements',          sub: 'Track payments',           route: AppRoutes.settlements,    color: Color(0xFF7B3F9E)),
    (icon: Icons.bar_chart_rounded,             label: 'Reports',              sub: 'Generate reports',          route: AppRoutes.reports,        color: AppColors.primary),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Text('Quick Actions',
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
        ),
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 4),
        ..._actions.map((a) => _ActionTile(icon: a.icon, label: a.label, sub: a.sub, route: a.route, color: a.color)),
        const SizedBox(height: 4),
      ]),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  final String route;
  final Color color;
  const _ActionTile({required this.icon, required this.label, required this.sub, required this.route, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(route),
      hoverColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(9)),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            Text(sub, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight)),
          ])),
          const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textLight),
        ]),
      ),
    );
  }
}

// ── Pay badge ─────────────────────────────────────────────────────────────────
class _PayBadge extends StatelessWidget {
  final bool paid;
  const _PayBadge({required this.paid});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: paid ? AppColors.primaryLight : const Color(0xFFDD6B20).withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(paid ? 'Paid' : 'Unpaid',
          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600,
              color: paid ? AppColors.primary : const Color(0xFFDD6B20))),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  REUSABLE APP TOP BAR
// ════════════════════════════════════════════════════════════
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final List<String>? breadcrumbs;

  const AppTopBar({
    super.key,
    required this.title,
    this.actions,
    this.breadcrumbs,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (breadcrumbs != null)
              Text(breadcrumbs!.join(' › '),
                  style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500)),
            Text(title,
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark)),
          ],
        ),
        const Spacer(),
        if (actions != null) ...actions!,
      ]),
    );
  }
}