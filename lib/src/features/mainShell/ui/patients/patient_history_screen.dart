import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicity_tpa/src/features/mainShell/ui/patients/patient_list_screen.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../models/models.dart';


class PatientHistoryScreen extends StatelessWidget {
  final String tpaId;
  final String companyId;
  final String patientId;
  const PatientHistoryScreen({super.key, required this.tpaId, required this.companyId, required this.patientId});

  @override
  Widget build(BuildContext context) {
    final patient = allPatients.firstWhere((p) => p.id == patientId, orElse: () => allPatients.first);
    final history = allCollections.where((c) => c.patientId == patientId).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24), color: Colors.white,
        child: Row(children: [
          InkWell(onTap: () => context.go('/tpa/$tpaId/companies/$companyId/patients'), child: Row(children: [
            const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
            const SizedBox(width: 4),
            Text('Patients', style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
          ])),
          const SizedBox(width: 12),
          Text('Sample History — ${patient.name}', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700)),
        ]),
      )),
      body: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
        Row(children: [
          _card('Total Visits', '${history.length}', const Color(0xFF0B833D)),
          const SizedBox(width: 12),
          _card('Total Billed', '₹${history.fold(0.0, (s, c) => s + c.amount).toStringAsFixed(0)}', const Color(0xFF1565C0)),
          const SizedBox(width: 12),
          _card('Paid', '${history.where((c) => c.paymentReceived).length}', const Color(0xFF0B833D)),
          const SizedBox(width: 12),
          _card('Pending', '${history.where((c) => !c.paymentReceived).length}', const Color(0xFFDD6B20)),
        ]),
        const SizedBox(height: 20),
        Expanded(child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE9ECEF))),
          child: history.isEmpty
              ? Center(child: Text('No history found', style: GoogleFonts.inter(color: const Color(0xFFADB5BD))))
              : ListView.separated(
              itemCount: history.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
              itemBuilder: (_, i) {
                final c = history[i];
                return ListTile(
                  leading: Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFF0B833D).withOpacity(0.10), borderRadius: BorderRadius.circular(9)),
                      child: const Icon(Icons.biotech_rounded, size: 18, color: Color(0xFF0B833D))),
                  title: Text(c.tests, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                  subtitle: Text('${c.date.day}/${c.date.month}/${c.date.year}  ·  ₹${c.amount.toStringAsFixed(0)}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD))),
                  trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: c.paymentReceived ? const Color(0xFF0B833D).withOpacity(0.08) : const Color(0xFFDD6B20).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(c.paymentReceived ? 'Paid  ${c.invoiceNo}' : 'Unpaid', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
                          color: c.paymentReceived ? const Color(0xFF0B833D) : const Color(0xFFDD6B20)))),
                );
              }),
        )),
      ])),
    );
  }

  Widget _card(String label, String val, Color c) => Expanded(child: Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE9ECEF))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(val, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: c)),
      Text(label, style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD))),
    ]),
  ));
}