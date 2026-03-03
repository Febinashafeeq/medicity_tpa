// lib/src/features/tpa/screens/add_tpa_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../services/tpa_provider.dart';
import '../../../../shared/theme/app_colors.dart';

class AddTpaScreen extends StatefulWidget {
  const AddTpaScreen({super.key});

  @override
  State<AddTpaScreen> createState() => _AddTpaScreenState();
}

class _AddTpaScreenState extends State<AddTpaScreen> {
  final _nameCtrl   = TextEditingController();
  final _codeCtrl   = TextEditingController();
  final _personCtrl = TextEditingController();
  final _phoneCtrl  = TextEditingController();
  final _cityCtrl   = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _codeCtrl.dispose();
    _personCtrl.dispose();
    _phoneCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty || _codeCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('TPA Name and Code are required.',
              style: GoogleFonts.inter(fontSize: 13)),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    setState(() => _saving = true);

    await context.read<TpaProvider>().addTpa(
      name:          _nameCtrl.text.trim(),
      code:          _codeCtrl.text.trim(),
      contactPerson: _personCtrl.text.trim(),
      phone:         _phoneCtrl.text.trim(),
      city:          _cityCtrl.text.trim(),
    );

    if (mounted) {
      setState(() => _saving = false);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: AppColors.white,
        shadowColor: Colors.black.withOpacity(0.08),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              size: 18, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ledger Management',
                style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500)),
            Text('Add New TPA',
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark)),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Form card ──────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(9)),
                    child: const Icon(Icons.business_rounded,
                        color: AppColors.primary, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Text('TPA Details',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark)),
                ]),
                const SizedBox(height: 20),
                _formField('TPA Name *',     _nameCtrl,   'e.g. Medi Assist TPA'),
                _formField('TPA Code *',     _codeCtrl,   'e.g. MA001'),
                _formField('Contact Person', _personCtrl, 'Full name'),
                _formField('Phone',          _phoneCtrl,  '10-digit number',
                    keyboardType: TextInputType.phone),
                _formField('City',           _cityCtrl,   'City name',
                    isLast: true),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Save button ────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saving ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: _saving
                  ? const SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
                  : Text('Save TPA',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 15)),
            ),
          ),

          const SizedBox(height: 12),

          // ── Cancel button ──────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 48,
            child: TextButton(
              onPressed: () => context.pop(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textMid,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Cancel',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Form field helper ──────────────────────────────────────────────────────
Widget _formField(
    String label,
    TextEditingController ctrl,
    String hint, {
      TextInputType keyboardType = TextInputType.text,
      bool isLast = false,
    }) =>
    Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
              GoogleFonts.inter(fontSize: 13, color: AppColors.textLight),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5)),
            ),
          ),
        ],
      ),
    );