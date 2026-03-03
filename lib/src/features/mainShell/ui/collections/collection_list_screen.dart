import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/collection_provider.dart';
import '../../../../services/insurance_provider.dart';
import '../../../../services/patients_provider.dart';
import '../../../../shared/constants/responsive_helper.dart';
import '../../../../shared/theme/app_colors.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tpa/tpa_detail_screen.dart';
import '../tpa/tpa_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';


// class CollectionListScreen extends StatelessWidget {
//   const CollectionListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => CollectionProvider()),
//         ChangeNotifierProvider(create: (_) => PatientProvider()),
//         ChangeNotifierProvider(create: (_) => InsuranceProvider()),
//       ],
//       child: const _CollectionListView(),
//     );
//   }
// }
//
// class _CollectionListView extends StatelessWidget {
//   const _CollectionListView();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: Column(children: [
//         const _TopBar(),
//         Expanded(child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(children: [
//             const _SummaryRow(),
//             const SizedBox(height: 20),
//             const Expanded(child: _CollectionTable()),
//           ]),
//         )),
//       ]),
//     );
//   }
// }
//
// // ── Top Bar ───────────────────────────────────────────────────────────────────
// class _TopBar extends StatelessWidget {
//   const _TopBar();
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<CollectionProvider>();
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       color: Colors.white,
//       child: Row(children: [
//         Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text('Daily Operations', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
//           Text('Sample Collections', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
//         ]),
//         const Spacer(),
//         const _FilterChips(),
//         const SizedBox(width: 12),
//         Consumer<CollectionProvider>(
//           builder: (_, p, __) => InkWell(
//             onTap: () async {
//               final d = await showDatePicker(
//                 context: context, initialDate: p.selectedDate,
//                 firstDate: DateTime(2020), lastDate: DateTime.now(),
//                 builder: (ctx, child) => Theme(data: ThemeData(colorSchemeSeed: const Color(0xFF0B833D)), child: child!),
//               );
//               if (d != null) provider.setDate(d);
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE9ECEF))),
//               child: Row(children: [
//                 const Icon(Icons.calendar_today_rounded, size: 15, color: Color(0xFF0B833D)),
//                 const SizedBox(width: 8),
//                 Text(_fmt(p.selectedDate), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//               ]),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
//
// // ── Filter Chips ──────────────────────────────────────────────────────────────
// class _FilterChips extends StatelessWidget {
//   const _FilterChips();
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<CollectionProvider>();
//     return Row(
//       children: ['All', 'Paid', 'Unpaid'].map((s) =>
//           Padding(
//             padding: const EdgeInsets.only(right: 6),
//             child: InkWell(
//               onTap: () => context.read<CollectionProvider>().setFilterStatus(s),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: provider.filterStatus == s ? const Color(0xFF0B833D) : const Color(0xFFF8F9FA),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: provider.filterStatus == s ? const Color(0xFF0B833D) : const Color(0xFFE9ECEF)),
//                 ),
//                 child: Text(s, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600,
//                     color: provider.filterStatus == s ? Colors.white : const Color(0xFF495057))),
//               ),
//             ),
//           ),
//       ).toList(),
//     );
//   }
// }
//
// // ── Summary Row ───────────────────────────────────────────────────────────────
// class _SummaryRow extends StatelessWidget {
//   const _SummaryRow();
//
//   @override
//   Widget build(BuildContext context) {
//     final summary = context.watch<CollectionProvider>().summary;
//     return Row(children: [
//       _SummaryCard(label: 'Total Collections', value: '${summary.total}', icon: Icons.biotech_rounded, color: const Color(0xFF1565C0)),
//       const SizedBox(width: 12),
//       _SummaryCard(label: 'Payments Received', value: '${summary.paid}', icon: Icons.check_circle_rounded, color: const Color(0xFF0B833D)),
//       const SizedBox(width: 12),
//       _SummaryCard(label: 'Pending', value: '${summary.unpaid}', icon: Icons.pending_rounded, color: const Color(0xFFDD6B20)),
//       const SizedBox(width: 12),
//       _SummaryCard(label: 'Total Amount', value: '₹${summary.amount.toStringAsFixed(0)}', icon: Icons.currency_rupee_rounded, color: const Color(0xFF0B833D)),
//     ]);
//   }
// }
//
// // ── Collection Table ──────────────────────────────────────────────────────────
// class _CollectionTable extends StatelessWidget {
//   const _CollectionTable();
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<CollectionProvider>();
//     return Container(
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE9ECEF))),
//       child: Column(children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
//           child: Row(children: [
//             const Icon(Icons.biotech_rounded, size: 16, color: Color(0xFF0B833D)),
//             const SizedBox(width: 8),
//             Text('Collections — ${_fmt(provider.selectedDate)}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
//           ]),
//         ),
//         _tableHeader(),
//         Expanded(child: provider.filteredCollections.isEmpty
//             ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           const Icon(Icons.biotech_outlined, size: 40, color: Color(0xFFADB5BD)),
//           const SizedBox(height: 10),
//           Text('No collections for ${_fmt(provider.selectedDate)}', style: GoogleFonts.inter(color: const Color(0xFFADB5BD))),
//         ]))
//             : ListView.separated(
//           itemCount: provider.filteredCollections.length,
//           separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
//           itemBuilder: (ctx, i) => _CollectionRow(collection: provider.filteredCollections[i]),
//         )),
//       ]),
//     );
//   }
//
//   Widget _tableHeader() => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     color: const Color(0xFFF8F9FA),
//     child: Row(children: [
//       _hCell('PATIENT', 2), _hCell('COMPANY', 2), _hCell('TESTS', 2),
//       _hCell('STATUS', 1), _hCell('AMOUNT', 1), _hCell('PAYMENT', 1),
//       _hCell('INVOICE', 1), _hCell('ACTION', 1),
//     ]),
//   );
// }
//
// // ── Collection Row ────────────────────────────────────────────────────────────
// class _CollectionRow extends StatelessWidget {
//   final SampleCollectionModel collection;
//   const _CollectionRow({required this.collection});
//
//   @override
//   Widget build(BuildContext context) {
//     final patient = allPatients.firstWhere((p) => p.id == collection.patientId, orElse: () => allPatients.first);
//     final company = allCompanies.firstWhere((c) => c.id == collection.companyId, orElse: () => allCompanies.first);
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Row(children: [
//         Expanded(flex: 2, child: Row(children: [
//           CircleAvatar(
//             radius: 14,
//             backgroundColor: const Color(0xFF0B833D).withOpacity(0.10),
//             child: Text(patient.name[0], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D))),
//           ),
//           const SizedBox(width: 8),
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(patient.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//             Text('${patient.age}y · ${patient.gender}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD))),
//           ]),
//         ])),
//         Expanded(flex: 2, child: Text(company.name, style: _cellStyle, overflow: TextOverflow.ellipsis)),
//         Expanded(flex: 2, child: Text(collection.tests, style: _cellStyle, overflow: TextOverflow.ellipsis)),
//         Expanded(flex: 1, child: _sampleBadge(collection.sampleStatus)),
//         Expanded(flex: 1, child: Text('₹${collection.amount.toStringAsFixed(0)}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600))),
//         Expanded(flex: 1, child: _payBadge(collection.paymentReceived)),
//         Expanded(flex: 1, child: Text(
//           collection.invoiceNo.isEmpty ? '—' : collection.invoiceNo,
//           style: GoogleFonts.inter(fontSize: 12, color: collection.invoiceNo.isEmpty ? const Color(0xFFADB5BD) : const Color(0xFF0B833D), fontWeight: FontWeight.w600),
//         )),
//         Expanded(flex: 1, child: ElevatedButton(
//           onPressed: () => context.go('/collections/${collection.id}/payment'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: collection.paymentReceived ? const Color(0xFFF8F9FA) : const Color(0xFF0B833D),
//             foregroundColor: collection.paymentReceived ? const Color(0xFF495057) : Colors.white,
//             elevation: 0, minimumSize: Size.zero,
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//           ),
//           child: Text(collection.paymentReceived ? 'View' : 'Enter Payment', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
//         )),
//       ]),
//     );
//   }
//
//   TextStyle get _cellStyle => GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057));
//
//   Widget _sampleBadge(String status) {
//     final colors = {'Collected': const Color(0xFF1565C0), 'Processing': const Color(0xFFDD6B20), 'Reported': const Color(0xFF0B833D)};
//     final c = colors[status] ?? const Color(0xFF495057);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
//       child: Text(status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: c)),
//     );
//   }
//
//   Widget _payBadge(bool paid) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//     decoration: BoxDecoration(
//       color: paid ? const Color(0xFF0B833D).withOpacity(0.08) : const Color(0xFFDD6B20).withOpacity(0.08),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Text(paid ? 'Paid' : 'Unpaid', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
//         color: paid ? const Color(0xFF0B833D) : const Color(0xFFDD6B20))),
//   );
// }
//
// // ── Reusable Widgets ──────────────────────────────────────────────────────────
// class _SummaryCard extends StatelessWidget {
//   final String label;
//   final String value;
//   final IconData icon;
//   final Color color;
//   const _SummaryCard({required this.label, required this.value, required this.icon, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(child: Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE9ECEF))),
//       child: Row(children: [
//         Container(width: 36, height: 36,
//           decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(9)),
//           child: Icon(icon, size: 18, color: color),
//         ),
//         const SizedBox(width: 10),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF212529))),
//           Text(label, style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
//         ]),
//       ]),
//     ));
//   }
// }
//
// Widget _hCell(String t, int flex) => Expanded(
//   flex: flex,
//   child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
// );
//
// String _fmt(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

/// changed for responsive




// ════════════════════════════════════════════════════════════
//  COLLECTION LIST SCREEN
// ════════════════════════════════════════════════════════════
class CollectionListScreen extends StatelessWidget {
  const CollectionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // FIX: fetch on create
        ChangeNotifierProvider(create: (_) => CollectionProvider()..fetchAll()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => InsuranceProvider()),
      ],
      child: const _CollectionListView(),
    );
  }
}

class _CollectionListView extends StatelessWidget {
  const _CollectionListView();

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.pagePadding(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(children: [
        const _TopBar(),
        Expanded(child: Padding(
          padding: EdgeInsets.all(padding),
          child: const Column(children: [
            _SummaryRow(),
            SizedBox(height: 20),
            Expanded(child: _CollectionTable()),
          ]),
        )),
      ]),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CollectionProvider>();
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
      color: Colors.white,
      child: isMobile
          ? Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          height: 52,
          child: Row(children: [
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Daily Operations', style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
                Text('Sample Collections', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
              ],
            )),
            _DateButton(provider: provider),
          ]),
        ),
        SizedBox(height: 44, child: Row(children: [const Expanded(child: _FilterChips())])),
        Container(height: 1, color: const Color(0xFFE9ECEF)),
      ])
          : SizedBox(
        height: 60,
        child: Row(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Daily Operations', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
            Text('Sample Collections', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
          ]),
          const Spacer(),
          const _FilterChips(),
          const SizedBox(width: 12),
          _DateButton(provider: provider),
        ]),
      ),
    );
  }
}

class _DateButton extends StatelessWidget {
  final CollectionProvider provider;
  const _DateButton({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionProvider>(
      builder: (_, p, __) => InkWell(
        onTap: () async {
          final d = await showDatePicker(
            context: context, initialDate: p.selectedDate,
            firstDate: DateTime(2020), lastDate: DateTime.now(),
            builder: (ctx, child) => Theme(
                data: ThemeData(colorSchemeSeed: const Color(0xFF0B833D)), child: child!),
          );
          if (d != null) provider.setDate(d);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE9ECEF)),
          ),
          child: Row(children: [
            const Icon(Icons.calendar_today_rounded, size: 15, color: Color(0xFF0B833D)),
            const SizedBox(width: 8),
            Text(_fmt(p.selectedDate),
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
          ]),
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CollectionProvider>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: ['All', 'Paid', 'Unpaid'].map((s) => Padding(
        padding: const EdgeInsets.only(right: 6),
        child: InkWell(
          onTap: () => context.read<CollectionProvider>().setFilterStatus(s),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: provider.filterStatus == s ? const Color(0xFF0B833D) : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: provider.filterStatus == s ? const Color(0xFF0B833D) : const Color(0xFFE9ECEF)),
            ),
            child: Text(s, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600,
                color: provider.filterStatus == s ? Colors.white : const Color(0xFF495057))),
          ),
        ),
      )).toList(),
    );
  }
}

// ── Summary Row ───────────────────────────────────────────────────────────────
class _SummaryRow extends StatelessWidget {
  const _SummaryRow();

  @override
  Widget build(BuildContext context) {
    final summary  = context.watch<CollectionProvider>().summary;
    final isMobile = ResponsiveHelper.isMobile(context);

    final cards = [
      _SummaryCard(label: 'Total Collections', value: '${summary.total}',                       icon: Icons.biotech_rounded,        color: const Color(0xFF1565C0)),
      _SummaryCard(label: 'Payments Received', value: '${summary.paid}',                        icon: Icons.check_circle_rounded,   color: const Color(0xFF0B833D)),
      _SummaryCard(label: 'Pending',           value: '${summary.unpaid}',                      icon: Icons.pending_rounded,        color: const Color(0xFFDD6B20)),
      _SummaryCard(label: 'Total Amount',      value: '₹${summary.amount.toStringAsFixed(0)}',  icon: Icons.currency_rupee_rounded, color: const Color(0xFF0B833D)),
    ];

    if (isMobile) {
      return Column(children: [
        Row(children: [cards[0], const SizedBox(width: 12), cards[1]]),
        const SizedBox(height: 12),
        Row(children: [cards[2], const SizedBox(width: 12), cards[3]]),
      ]);
    }
    return Row(children: [
      cards[0], const SizedBox(width: 12),
      cards[1], const SizedBox(width: 12),
      cards[2], const SizedBox(width: 12),
      cards[3],
    ]);
  }
}

// ── Collection Table ──────────────────────────────────────────────────────────
class _CollectionTable extends StatelessWidget {
  const _CollectionTable();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CollectionProvider>();
    final isMobile = ResponsiveHelper.isMobile(context);

    // Loading state
    if (provider.loading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE9ECEF)),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFF0B833D)),
        ),
      );
    }

    // Error state
    if (provider.error != null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE9ECEF)),
        ),
        child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.error_outline_rounded, size: 40, color: Color(0xFFDD6B20)),
          const SizedBox(height: 10),
          Text('Failed to load collections', style: GoogleFonts.inter(color: const Color(0xFFDD6B20))),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => provider.fetchAll(),
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: Text('Retry', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            style: TextButton.styleFrom(foregroundColor: const Color(0xFF0B833D)),
          ),
        ])),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
          child: Row(children: [
            const Icon(Icons.biotech_rounded, size: 16, color: Color(0xFF0B833D)),
            const SizedBox(width: 8),
            Expanded(child: Text('Collections — ${_fmt(provider.selectedDate)}',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis)),
            // Refresh button
            InkWell(
              onTap: () => provider.fetchAll(),
              borderRadius: BorderRadius.circular(6),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.refresh_rounded, size: 16, color: Color(0xFFADB5BD)),
              ),
            ),
          ]),
        ),
        if (!isMobile) _tableHeader(),
        Expanded(child: provider.filteredCollections.isEmpty
            ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.biotech_outlined, size: 40, color: Color(0xFFADB5BD)),
          const SizedBox(height: 10),
          Text('No collections for ${_fmt(provider.selectedDate)}',
              style: GoogleFonts.inter(color: const Color(0xFFADB5BD))),
        ]))
            : ListView.separated(
          itemCount: provider.filteredCollections.length,
          separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
          itemBuilder: (ctx, i) => isMobile
              ? _CollectionMobileCard(collection: provider.filteredCollections[i])
              : _CollectionRow(collection: provider.filteredCollections[i]),
        )),
      ]),
    );
  }

  Widget _tableHeader() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    color: const Color(0xFFF8F9FA),
    child: Row(children: [
      _hCell('PATIENT', 2), _hCell('COMPANY', 2), _hCell('TESTS', 2),
      _hCell('STATUS', 1), _hCell('AMOUNT', 1), _hCell('PAYMENT', 1),
      _hCell('INVOICE', 1), _hCell('ACTION', 1),
    ]),
  );
}

// ── Collection Row (tablet / desktop) ─────────────────────────────────────────
class _CollectionRow extends StatelessWidget {
  final SampleCollectionModel collection;
  const _CollectionRow({required this.collection});

  @override
  Widget build(BuildContext context) {
    // FIX: use provider cache, not allPatients/allCompanies
    final provider = context.read<CollectionProvider>();
    final patient  = provider.patientById(collection.patientId);
    final company  = provider.companyById(collection.companyId);
    final name     = patient?.name     ?? '—';
    final compName = company?.name     ?? '—';
    final age      = patient?.age      ?? 0;
    final gender   = patient?.gender   ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(children: [
        Expanded(flex: 2, child: Row(children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFF0B833D).withOpacity(0.10),
            child: Text(name.isNotEmpty ? name[0] : '?',
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D))),
          ),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529)),
                overflow: TextOverflow.ellipsis),
            Text('${age}y · $gender', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD))),
          ])),
        ])),
        Expanded(flex: 2, child: Text(compName, style: _cellStyle, overflow: TextOverflow.ellipsis)),
        Expanded(flex: 2, child: Text(collection.tests, style: _cellStyle, overflow: TextOverflow.ellipsis)),
        Expanded(flex: 1, child: _sampleBadge(collection.sampleStatus)),
        Expanded(flex: 1, child: Text('₹${collection.amount.toStringAsFixed(0)}',
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600))),
        Expanded(flex: 1, child: _payBadge(collection.paymentReceived)),
        Expanded(flex: 1, child: Text(
          collection.invoiceNo.isEmpty ? '—' : collection.invoiceNo,
          style: GoogleFonts.inter(fontSize: 12,
              color: collection.invoiceNo.isEmpty ? const Color(0xFFADB5BD) : const Color(0xFF0B833D),
              fontWeight: FontWeight.w600),
        )),
        Expanded(flex: 1, child: ElevatedButton(
          onPressed: () => context.go('/collections/${collection.id}/payment'),
          style: ElevatedButton.styleFrom(
            backgroundColor: collection.paymentReceived ? const Color(0xFFF8F9FA) : const Color(0xFF0B833D),
            foregroundColor: collection.paymentReceived ? const Color(0xFF495057) : Colors.white,
            elevation: 0, minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Text(collection.paymentReceived ? 'View' : 'Enter Payment',
              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
        )),
      ]),
    );
  }

  TextStyle get _cellStyle => GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057));
}

// ── Collection Mobile Card ────────────────────────────────────────────────────
class _CollectionMobileCard extends StatelessWidget {
  final SampleCollectionModel collection;
  const _CollectionMobileCard({required this.collection});

  @override
  Widget build(BuildContext context) {
    // FIX: use provider cache
    final provider = context.read<CollectionProvider>();
    final patient  = provider.patientById(collection.patientId);
    final company  = provider.companyById(collection.companyId);
    final name     = patient?.name   ?? '—';
    final compName = company?.name   ?? '—';
    final age      = patient?.age    ?? 0;
    final gender   = patient?.gender ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFF0B833D).withOpacity(0.10),
            child: Text(name.isNotEmpty ? name[0] : '?',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D))),
          ),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
            Text('${age}y · $gender · $compName',
                style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD)),
                overflow: TextOverflow.ellipsis),
          ])),
          _payBadge(collection.paymentReceived),
        ]),
        const SizedBox(height: 10),
        Text(collection.tests, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057))),
        const SizedBox(height: 10),
        Row(children: [
          _sampleBadge(collection.sampleStatus),
          const SizedBox(width: 10),
          Text('₹${collection.amount.toStringAsFixed(0)}',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
          const Spacer(),
          if (collection.invoiceNo.isNotEmpty)
            Text(collection.invoiceNo,
                style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF0B833D), fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go('/collections/${collection.id}/payment'),
            style: ElevatedButton.styleFrom(
              backgroundColor: collection.paymentReceived ? const Color(0xFFF8F9FA) : const Color(0xFF0B833D),
              foregroundColor: collection.paymentReceived ? const Color(0xFF495057) : Colors.white,
              elevation: 0, padding: const EdgeInsets.symmetric(vertical: 10),
              side: collection.paymentReceived ? const BorderSide(color: Color(0xFFE9ECEF)) : BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(collection.paymentReceived ? 'View Payment' : 'Enter Payment',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ),
      ]),
    );
  }
}

// ── Reusable Widgets ──────────────────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _SummaryCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(9)),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF212529))),
          Text(label, style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis),
        ])),
      ]),
    ));
  }
}

Widget _sampleBadge(String status) {
  final colors = {'Collected': const Color(0xFF1565C0), 'Processing': const Color(0xFFDD6B20), 'Reported': const Color(0xFF0B833D)};
  final c = colors[status] ?? const Color(0xFF495057);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
    child: Text(status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: c)),
  );
}

Widget _payBadge(bool paid) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
  decoration: BoxDecoration(
    color: paid ? const Color(0xFF0B833D).withOpacity(0.08) : const Color(0xFFDD6B20).withOpacity(0.08),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(paid ? 'Paid' : 'Unpaid', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
      color: paid ? const Color(0xFF0B833D) : const Color(0xFFDD6B20))),
);

Widget _hCell(String t, int flex) => Expanded(
  flex: flex,
  child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700,
      color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
);

String _fmt(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';