import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class PatientDetailScreen extends StatelessWidget {
  final String tpaId;
  final String companyId;
  final String patientId;
  const PatientDetailScreen({super.key, required this.tpaId, required this.companyId, required this.patientId});

  @override
  Widget build(BuildContext context) {
    final patient = allPatients.firstWhere((p) => p.id == patientId, orElse: () => allPatients.first);
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
          Text('Patient Detail — ${patient.name}', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
        ]),
      )),
      body: Center(child: Text('Patient detail for ${patient.name}', style: GoogleFonts.inter())),
    );
  }
}



