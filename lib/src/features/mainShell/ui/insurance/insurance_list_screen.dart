import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tpa/tpa_detail_screen.dart';

class InsuranceListScreen extends StatelessWidget {
  final String tpaId;
  const InsuranceListScreen({super.key, required this.tpaId});
  @override
  Widget build(BuildContext context) {
    // Redirect to tpa detail which shows companies
    WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/tpa/$tpaId'));
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

