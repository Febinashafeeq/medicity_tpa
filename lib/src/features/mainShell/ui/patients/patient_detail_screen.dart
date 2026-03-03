import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../services/patients_provider.dart';
import '../../../../shared/constants/responsive_helper.dart';
import '../../../../shared/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/models.dart';
import 'patient_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'patient_list_screen.dart';

// ════════════════════════════════════════════════════════════
//  PATIENT DETAIL SCREEN  — real content, not placeholder
// ════════════════════════════════════════════════════════════
class PatientDetailScreen extends StatelessWidget {
  final String tpaId;
  final String companyId;
  final String patientId;
  const PatientDetailScreen({
    super.key,
    required this.tpaId,
    required this.companyId,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PatientProvider()..fetchPatients(companyId: companyId),
      child: _PatientDetailView(
        tpaId: tpaId, companyId: companyId, patientId: patientId,
      ),
    );
  }
}

class _PatientDetailView extends StatelessWidget {
  final String tpaId, companyId, patientId;
  const _PatientDetailView({
    required this.tpaId, required this.companyId, required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientProvider>();
    final isMobile = ResponsiveHelper.isMobile(context);
    final padding  = ResponsiveHelper.pagePadding(context);

    // Show loading while fetching
    if (provider.loading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: _detailAppBar(context, isMobile, null),
        body: const Center(child: CircularProgressIndicator(color: Color(0xFF0B833D))),
      );
    }

    final patient = provider.getPatientById(patientId);
    if (patient == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: _detailAppBar(context, isMobile, null),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.person_off_outlined, size: 48, color: Color(0xFFADB5BD)),
            const SizedBox(height: 12),
            Text('Patient not found',
                style: GoogleFonts.inter(fontSize: 16, color: const Color(0xFFADB5BD))),
          ]),
        ),
      );
    }

    final history = allCollections.where((c) => c.patientId == patientId).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _detailAppBar(context, isMobile, patient),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: isMobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _PatientInfoCard(patient: patient),
          const SizedBox(height: 16),
          _PatientStatsCard(history: history),
          const SizedBox(height: 16),
          _PatientHistoryCard(history: history, isMobile: true),
        ])
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left column: info + stats
          SizedBox(
            width: 300,
            child: Column(children: [
              _PatientInfoCard(patient: patient),
              const SizedBox(height: 16),
              _PatientStatsCard(history: history),
            ]),
          ),
          const SizedBox(width: 20),
          // Right column: history table
          Expanded(child: _PatientHistoryCard(history: history, isMobile: false)),
        ]),
      ),
    );
  }

  PreferredSizeWidget _detailAppBar(BuildContext context, bool isMobile, PatientModel? patient) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
        color: Colors.white,
        child: Row(children: [
          InkWell(
            onTap: () => context.go('/tpa/$tpaId/companies/$companyId/patients'),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Row(children: [
                const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
                const SizedBox(width: 4),
                Text('Patients', style: GoogleFonts.inter(
                    fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
              ]),
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 16, color: Color(0xFFADB5BD)),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              patient?.name ?? '...',
              style: GoogleFonts.inter(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF212529)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // History button
          if (patient != null)
            TextButton.icon(
              onPressed: () => context.go(
                  '/tpa/$tpaId/companies/$companyId/patients/$patientId/history'),
              icon: const Icon(Icons.history_rounded, size: 15),
              label: isMobile
                  ? const SizedBox.shrink()
                  : Text('History', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF0B833D),
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 8),
              ),
            ),
        ]),
      ),
    );
  }
}

// ── Patient Info Card ─────────────────────────────────────────
class _PatientInfoCard extends StatelessWidget {
  final PatientModel patient;
  const _PatientInfoCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.person_rounded, size: 15, color: Color(0xFF0B833D)),
          const SizedBox(width: 8),
          Text('Patient Information',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
        ]),
        const SizedBox(height: 16),
        // Avatar + name
        Row(children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF0B833D).withOpacity(0.10),
            child: Text(patient.name[0],
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF0B833D))),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(patient.name,
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
            Text('${patient.age} yrs · ${patient.gender}',
                style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD))),
          ])),
        ]),
        const SizedBox(height: 14),
        const Divider(height: 1, color: Color(0xFFF1F3F5)),
        const SizedBox(height: 14),
        _infoRow(Icons.badge_rounded,           'Policy No.',  patient.policyNo),
        _infoRow(Icons.credit_card_rounded,     'Card No.',    patient.cardNo.isEmpty ? '—' : patient.cardNo),
        _infoRow(Icons.phone_rounded,           'Phone',       patient.phone.isEmpty ? '—' : patient.phone),
        _infoRow(Icons.location_on_rounded,     'Address',     patient.address.isEmpty ? '—' : patient.address),
        _infoRow(Icons.home_work_rounded,       'Visit Type',  patient.visitType),
        _infoRow(Icons.business_rounded,        'Company',     patient.companyName),
        _infoRow(Icons.local_hospital_rounded,  'TPA',         patient.tpaName),
      ]),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(children: [
      Icon(icon, size: 13, color: const Color(0xFFADB5BD)),
      const SizedBox(width: 8),
      SizedBox(width: 76,
          child: Text(label,
              style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500))),
      Expanded(child: Text(value,
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF212529)))),
    ]),
  );
}

// ── Stats Card ────────────────────────────────────────────────
class _PatientStatsCard extends StatelessWidget {
  final List<SampleCollectionModel> history;
  const _PatientStatsCard({required this.history});

  @override
  Widget build(BuildContext context) {
    final paid   = history.where((c) =>  c.paymentReceived).length;
    final unpaid = history.where((c) => !c.paymentReceived).length;
    final total  = history.fold(0.0, (s, c) => s + c.amount);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.bar_chart_rounded, size: 15, color: Color(0xFF0B833D)),
          const SizedBox(width: 8),
          Text('Payment Summary',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
        ]),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10, mainAxisSpacing: 10,
          childAspectRatio: 2.2,
          children: [
            _miniStat('Visits',    '${history.length}', const Color(0xFF1565C0)),
            _miniStat('Paid',      '$paid',             const Color(0xFF0B833D)),
            _miniStat('Unpaid',    '$unpaid',           const Color(0xFFDD6B20)),
            _miniStat('Received',  '₹${history.where((c) => c.paymentReceived).fold(0.0, (s, c) => s + c.amount).toStringAsFixed(0)}', const Color(0xFF0B833D)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0B833D).withOpacity(0.06),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(children: [
            Text('Total Billed',
                style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057))),
            const Spacer(),
            Text('₹${total.toStringAsFixed(0)}',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: const Color(0xFF0B833D))),
          ]),
        ),
      ]),
    );
  }

  Widget _miniStat(String label, String value, Color color) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.15)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
      Text(label, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: color.withOpacity(0.75))),
    ]),
  );
}

// ── History Card ──────────────────────────────────────────────
class _PatientHistoryCard extends StatelessWidget {
  final List<SampleCollectionModel> history;
  final bool isMobile;
  const _PatientHistoryCard({required this.history, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
          child: Row(children: [
            const Icon(Icons.biotech_rounded, size: 15, color: Color(0xFF0B833D)),
            const SizedBox(width: 8),
            Text('Collection History',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: const Color(0xFF0B833D).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20)),
              child: Text('${history.length} records',
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF0B833D))),
            ),
          ]),
        ),
        // Table header (desktop only)
        if (!isMobile)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: const Color(0xFFF8F9FA),
            child: Row(children: [
              _hCell('DATE', 1), _hCell('TESTS', 2), _hCell('STATUS', 1),
              _hCell('AMOUNT', 1), _hCell('PAYMENT', 1), _hCell('ACTION', 1),
            ]),
          ),
        // List
        history.isEmpty
            ? Padding(
          padding: const EdgeInsets.all(32),
          child: Center(child: Column(children: [
            const Icon(Icons.biotech_outlined, size: 40, color: Color(0xFFADB5BD)),
            const SizedBox(height: 10),
            Text('No collection records found',
                style: GoogleFonts.inter(color: const Color(0xFFADB5BD))),
          ])),
        )
            : ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
          itemBuilder: (ctx, i) => isMobile
              ? _HistoryMobileTile(c: history[i])
              : _HistoryDesktopRow(c: history[i]),
        ),
      ]),
    );
  }
}

class _HistoryDesktopRow extends StatelessWidget {
  final SampleCollectionModel c;
  const _HistoryDesktopRow({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(children: [
        Expanded(flex: 1, child: Text(_fmt(c.date),
            style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057)))),
        Expanded(flex: 2, child: Text(c.tests,
            style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057)),
            overflow: TextOverflow.ellipsis)),
        Expanded(flex: 1, child: _sampleBadge(c.sampleStatus)),
        Expanded(flex: 1, child: Text('₹${c.amount.toStringAsFixed(0)}',
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF212529)))),
        Expanded(flex: 1, child: _payBadge(c.paymentReceived)),
        Expanded(flex: 1, child: ElevatedButton(
          onPressed: () => context.go('/collections/${c.id}/payment'),
          style: ElevatedButton.styleFrom(
            backgroundColor: c.paymentReceived ? const Color(0xFFF8F9FA) : const Color(0xFF0B833D),
            foregroundColor: c.paymentReceived ? const Color(0xFF495057) : Colors.white,
            elevation: 0, minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Text(c.paymentReceived ? 'View' : 'Enter Payment',
              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
        )),
      ]),
    );
  }
}

class _HistoryMobileTile extends StatelessWidget {
  final SampleCollectionModel c;
  const _HistoryMobileTile({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(_fmt(c.date),
              style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD))),
          const Spacer(),
          _sampleBadge(c.sampleStatus),
        ]),
        const SizedBox(height: 6),
        Text(c.tests,
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
        const SizedBox(height: 8),
        Row(children: [
          Text('₹${c.amount.toStringAsFixed(0)}',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
          const SizedBox(width: 8),
          _payBadge(c.paymentReceived),
          const Spacer(),
          if (c.invoiceNo.isNotEmpty)
            Text(c.invoiceNo,
                style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF0B833D), fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: () => context.go('/collections/${c.id}/payment'),
          style: ElevatedButton.styleFrom(
            backgroundColor: c.paymentReceived ? const Color(0xFFF8F9FA) : const Color(0xFF0B833D),
            foregroundColor: c.paymentReceived ? const Color(0xFF495057) : Colors.white,
            elevation: 0, padding: const EdgeInsets.symmetric(vertical: 10),
            side: c.paymentReceived ? const BorderSide(color: Color(0xFFE9ECEF)) : BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(c.paymentReceived ? 'View Payment' : 'Enter Payment',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
        )),
      ]),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────
Widget _hCell(String t, int flex) => Expanded(
  flex: flex,
  child: Text(t, style: GoogleFonts.inter(
      fontSize: 10, fontWeight: FontWeight.w700,
      color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
);

Widget _sampleBadge(String status) {
  final colors = {'Collected': const Color(0xFF1565C0), 'Processing': const Color(0xFFDD6B20), 'Reported': const Color(0xFF0B833D)};
  final c = colors[status] ?? const Color(0xFF495057);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
    child: Text(status, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: c)),
  );
}

Widget _payBadge(bool paid) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
  decoration: BoxDecoration(
    color: paid ? const Color(0xFF0B833D).withOpacity(0.08) : const Color(0xFFDD6B20).withOpacity(0.08),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(paid ? 'Paid' : 'Unpaid',
      style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600,
          color: paid ? const Color(0xFF0B833D) : const Color(0xFFDD6B20))),
);

String _fmt(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';



