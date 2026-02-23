import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';


class InsuranceDetailScreen extends StatelessWidget {
  final String tpaId;
  final String companyId;
  const InsuranceDetailScreen({super.key, required this.tpaId, required this.companyId});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/tpa/$tpaId/companies/$companyId/patients'));
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}