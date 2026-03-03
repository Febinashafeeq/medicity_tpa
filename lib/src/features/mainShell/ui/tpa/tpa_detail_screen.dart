import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../services/tpa_provider.dart';
import '../../../../shared/constants/responsive_helper.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../models/models.dart';


// class TpaDetailScreen extends StatelessWidget {
//   final String tpaId;
//   const TpaDetailScreen({super.key, required this.tpaId});
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider = context.read<TpaProvider>();
//       provider.fetchTpas();
//       provider.fetchCompanies(tpaId: tpaId);
//     });
//     return _TpaDetailView(tpaId: tpaId);
//   }
// }
//
// class _TpaDetailView extends StatelessWidget {
//   final String tpaId;
//   const _TpaDetailView({required this.tpaId});
//
//   @override
//   Widget build(BuildContext context) {
//     final tpa = context.watch<TpaProvider>().tpaById(tpaId);
//
//     if (tpa == null) {
//       return const Scaffold(
//         backgroundColor: Color(0xFFF8F9FA),
//         body: Center(
//           child: CircularProgressIndicator(color: Color(0xFF0B833D)),
//         ),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: Column(children: [
//         _TopBar(tpa: tpa),
//         Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Expanded(child: _CompanyContent(tpa: tpa, tpaId: tpaId)),
//           Consumer<TpaProvider>(
//             builder: (_, p, __) => p.showAddCompany ? _AddCompanyForm(tpaId: tpaId) : const SizedBox.shrink(),
//           ),
//         ])),
//       ]),
//     );
//   }
// }
//
// // ── Top Bar ───────────────────────────────────────────────────────────────────
// class _TopBar extends StatelessWidget {
//   final TpaModel tpa;
//   const _TopBar({required this.tpa});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<TpaProvider>();
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       color: Colors.white,
//       child: Row(children: [
//         InkWell(
//           onTap: () => context.go('/tpa'),
//           child: Row(children: [
//             const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
//             const SizedBox(width: 4),
//             Text('TPA List', style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
//           ]),
//         ),
//         const SizedBox(width: 12),
//         const Icon(Icons.chevron_right, size: 16, color: Color(0xFFADB5BD)),
//         const SizedBox(width: 8),
//         Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text('TPA Management › ${tpa.name}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
//           Text('Insurance Companies', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
//         ]),
//         const Spacer(),
//         Consumer<TpaProvider>(
//           builder: (_, p, __) => ElevatedButton.icon(
//             onPressed: provider.toggleAddCompany,
//             icon: Icon(p.showAddCompany ? Icons.close : Icons.add, size: 16),
//             label: Text(
//               p.showAddCompany ? 'Close' : 'Add Company',
//               style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
//
// // ── Company Content ───────────────────────────────────────────────────────────
// class _CompanyContent extends StatelessWidget {
//   final TpaModel tpa;
//   final String tpaId;
//   const _CompanyContent({required this.tpa, required this.tpaId});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider  = context.watch<TpaProvider>();
//     final companies = provider.companiesForTpa(tpaId);
//
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         // TPA Info Card
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE9ECEF))),
//           child: Row(children: [
//             Container(
//               width: 40, height: 40,
//               decoration: BoxDecoration(color: const Color(0xFF0B833D).withOpacity(0.10), borderRadius: BorderRadius.circular(10)),
//               child: const Icon(Icons.business_rounded, color: Color(0xFF0B833D), size: 20),
//             ),
//             const SizedBox(width: 14),
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(tpa.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
//               Text('Code: ${tpa.code}  ·  ${tpa.city}  ·  ${tpa.contactPerson}',
//                   style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD))),
//             ]),
//             const Spacer(),
//             _activeBadge(tpa.isActive),
//           ]),
//         ),
//         const SizedBox(height: 20),
//
//         // Companies Table
//         Expanded(child: Container(
//           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE9ECEF))),
//           child: Column(children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
//               child: Row(children: [
//                 Text('Insurance Companies under ${tpa.name}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
//                 const Spacer(),
//                 _tagChip('${companies.length} Total', const Color(0xFF0B833D)),
//                 const SizedBox(width: 8),
//                 _tagChip('${companies.where((c) => c.isActive).length} Active', const Color(0xFF0B833D)),
//               ]),
//             ),
//             _tableHeader(),
//             Expanded(child: companies.isEmpty
//                 ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               const Icon(Icons.business_outlined, size: 40, color: Color(0xFFADB5BD)),
//               const SizedBox(height: 10),
//               Text('No insurance companies yet', style: GoogleFonts.inter(color: const Color(0xFFADB5BD))),
//             ]))
//                 : ListView.separated(
//               itemCount: companies.length,
//               separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
//               itemBuilder: (ctx, i) => _CompanyRow(company: companies[i], tpaId: tpaId),
//             )),
//           ]),
//         )),
//       ]),
//     );
//   }
//
//   Widget _tableHeader() => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
//     decoration: const BoxDecoration(color: Color(0xFFF8F9FA), border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
//     child: Row(children: [
//       _hCell('COMPANY NAME', 3), _hCell('POLICY TYPE', 1), _hCell('EMP. NO', 1),
//       _hCell('CONTACT', 2),      _hCell('PHONE', 2),       _hCell('PATIENTS', 1),
//       _hCell('STATUS', 1),       _hCell('ACTION', 1),
//     ]),
//   );
// }
//
// // ── Company Row ───────────────────────────────────────────────────────────────
// class _CompanyRow extends StatelessWidget {
//   final InsuranceCompanyModel company;
//   final String tpaId;
//   const _CompanyRow({required this.company, required this.tpaId});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => context.go('/tpa/$tpaId/companies/${company.id}/patients'),
//       hoverColor: const Color(0xFFF8F9FA),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
//         child: Row(children: [
//           Expanded(flex: 3, child: Row(children: [
//             Container(
//               width: 30, height: 30,
//               decoration: BoxDecoration(color: const Color(0xFF1565C0).withOpacity(0.08), borderRadius: BorderRadius.circular(7)),
//               child: const Icon(Icons.verified_user_rounded, size: 15, color: Color(0xFF1565C0)),
//             ),
//             const SizedBox(width: 10),
//             Text(company.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//           ])),
//           Expanded(flex: 1, child: _policyChip(company.policyType)),
//           Expanded(flex: 1, child: Text(company.empanelmentNo, style: _cell)),
//           Expanded(flex: 2, child: Text(company.contactPerson, style: _cell)),
//           Expanded(flex: 2, child: Text(company.phone,         style: _cell)),
//           Expanded(flex: 1, child: Text('${company.patientCount}',
//               style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D)))),
//           Expanded(flex: 1, child: _activeBadge(company.isActive)),
//           Expanded(flex: 1, child: Row(children: [
//             IconButton(
//               icon: const Icon(Icons.people_rounded, size: 16, color: Color(0xFF0B833D)),
//               onPressed: () => context.go('/tpa/$tpaId/companies/${company.id}/patients'),
//               tooltip: 'View Patients', padding: EdgeInsets.zero, constraints: const BoxConstraints(),
//             ),
//             const SizedBox(width: 8),
//             IconButton(
//               icon: const Icon(Icons.edit_outlined, size: 15, color: Color(0xFFADB5BD)),
//               onPressed: () {},
//               tooltip: 'Edit', padding: EdgeInsets.zero, constraints: const BoxConstraints(),
//             ),
//           ])),
//         ]),
//       ),
//     );
//   }
//
//   TextStyle get _cell => GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057));
//
//   Widget _policyChip(String type) {
//     final colors = {
//       'Group':      const Color(0xFF0B833D),
//       'Corporate':  const Color(0xFF1565C0),
//       'Individual': const Color(0xFFDD6B20),
//     };
//     final c = colors[type] ?? const Color(0xFF495057);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
//       child: Text(type, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: c)),
//     );
//   }
// }
//
// // ── Add Company Form ──────────────────────────────────────────────────────────
// class _AddCompanyForm extends StatefulWidget {
//   final String tpaId;
//   const _AddCompanyForm({required this.tpaId});
//
//   @override
//   State<_AddCompanyForm> createState() => _AddCompanyFormState();
// }
//
// class _AddCompanyFormState extends State<_AddCompanyForm> {
//   final _nameCtrl   = TextEditingController();
//   final _typeCtrl   = TextEditingController();
//   final _empCtrl    = TextEditingController();
//   final _personCtrl = TextEditingController();
//   final _phoneCtrl  = TextEditingController();
//
//   @override
//   void dispose() {
//     _nameCtrl.dispose(); _typeCtrl.dispose(); _empCtrl.dispose();
//     _personCtrl.dispose(); _phoneCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<TpaProvider>();
//     return Container(
//       width: 300,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(left: BorderSide(color: Color(0xFFE9ECEF))),
//       ),
//       child: Column(children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//           decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
//           child: Row(children: [
//             Text('Add Insurance Company', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)),
//             const Spacer(),
//             IconButton(
//               icon: const Icon(Icons.close, size: 18),
//               onPressed: provider.closeAddCompany,
//               padding: EdgeInsets.zero, constraints: const BoxConstraints(),
//             ),
//           ]),
//         ),
//         Expanded(child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             _field('Company Name *',  _nameCtrl,   'e.g. Star Health'),
//             _field('Policy Type',     _typeCtrl,   'Group / Corporate / Individual'),
//             _field('Empanelment No.', _empCtrl,    'EMP001'),
//             _field('Contact Person',  _personCtrl, 'Full name'),
//             _field('Phone',           _phoneCtrl,  '10-digit number'),
//             const SizedBox(height: 8),
//             SizedBox(width: double.infinity, child: ElevatedButton(
//               onPressed: () {
//                 if (_nameCtrl.text.isEmpty) return;
//                 provider.addCompany(
//                   tpaId:         widget.tpaId,
//                   name:          _nameCtrl.text,
//                   policyType:    _typeCtrl.text.isEmpty ? 'Group' : _typeCtrl.text,
//                   empanelmentNo: _empCtrl.text,
//                   contactPerson: _personCtrl.text,
//                   phone:         _phoneCtrl.text,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
//                 padding: const EdgeInsets.symmetric(vertical: 13),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: Text('Save Company', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
//             )),
//           ]),
//         )),
//       ]),
//     );
//   }
// }
//
// // ── Shared Helpers ────────────────────────────────────────────────────────────
// Widget _hCell(String t, int flex) => Expanded(
//   flex: flex,
//   child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
// );
//
// Widget _activeBadge(bool active) => Container(
//   padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
//   decoration: BoxDecoration(
//     color: active ? const Color(0xFF0B833D).withOpacity(0.10) : const Color(0xFFADB5BD).withOpacity(0.12),
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: Text(
//     active ? 'Active' : 'Inactive',
//     style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
//         color: active ? const Color(0xFF0B833D) : const Color(0xFFADB5BD)),
//   ),
// );
//
// Widget _tagChip(String label, Color c) => Container(
//   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//   decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
//   child: Text(label, style: GoogleFonts.inter(fontSize: 11, color: c, fontWeight: FontWeight.w600)),
// );
//
// Widget _field(String label, TextEditingController ctrl, String hint) => Padding(
//   padding: const EdgeInsets.only(bottom: 14),
//   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//     Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//     const SizedBox(height: 5),
//     TextField(
//       controller: ctrl,
//       style: GoogleFonts.inter(fontSize: 13),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: GoogleFonts.inter(fontSize: 13, color: const Color(0xFFADB5BD)),
//         filled: true, fillColor: const Color(0xFFF8F9FA),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         border:        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
//         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
//         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0B833D), width: 1.5)),
//       ),
//     ),
//   ]),
// );

/// changed for responsive

// lib/src/features/mainShell/ui/tpa/tpa_detail_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
//  RESPONSIVE TPA DETAIL SCREEN
//  • Desktop  (≥1024px): 8-col company table  + side-panel Add form
//  • Tablet   (600–1023): 5-col company table  + bottom sheet Add form
//  • Mobile   (<600px):  Company card list     + bottom sheet Add form
// ─────────────────────────────────────────────────────────────────────────────

// ════════════════════════════════════════════════════════════
//  ROOT
// ════════════════════════════════════════════════════════════
class TpaDetailScreen extends StatelessWidget {
  final String tpaId;
  const TpaDetailScreen({super.key, required this.tpaId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<TpaProvider>();
      p.fetchTpas();
      p.fetchCompanies(tpaId: tpaId);
    });
    return _TpaDetailView(tpaId: tpaId);
  }
}

class _TpaDetailView extends StatelessWidget {
  final String tpaId;
  const _TpaDetailView({required this.tpaId});

  @override
  Widget build(BuildContext context) {
    final tpa       = context.watch<TpaProvider>().tpaById(tpaId);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    if (tpa == null) {
      return const Scaffold(
        backgroundColor: AppColors.surface,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(children: [
        _TopBar(tpa: tpa, tpaId: tpaId),
        Expanded(
          child: isDesktop
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _CompanyContent(tpa: tpa, tpaId: tpaId)),
            Consumer<TpaProvider>(
              builder: (_, p, __) => p.showAddCompany
                  ? _AddCompanyPanel(tpaId: tpaId)
                  : const SizedBox.shrink(),
            ),
          ])
              : _CompanyContent(tpa: tpa, tpaId: tpaId),
        ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  TOP BAR
// ════════════════════════════════════════════════════════════
class _TopBar extends StatelessWidget {
  final TpaModel tpa;
  final String tpaId;
  const _TopBar({required this.tpa, required this.tpaId});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TpaProvider>();
    final isMobile = ResponsiveHelper.isMobile(context);
    final padding  = ResponsiveHelper.pagePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: isMobile ? 10 : 0),
      constraints: BoxConstraints(minHeight: isMobile ? 60 : 60),
      color: AppColors.white,
      child: isMobile
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Back nav
        GestureDetector(
          onTap: () => context.go('/tpa'),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.arrow_back_ios_rounded, size: 13, color: AppColors.primary),
            const SizedBox(width: 4),
            Text('TPA List',
                style: GoogleFonts.inter(
                    fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
          ]),
        ),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(
            child: Text(tpa.name,
                style: GoogleFonts.inter(
                    fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textDark),
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 8),
          Consumer<TpaProvider>(
            builder: (_, p, __) => _AddButton(
              isOpen: p.showAddCompany,
              label: 'Add Co.',
              onTap: () => _handleAddTap(context, provider),
            ),
          ),
        ]),
      ])
      // Tablet / Desktop: single row
          : Row(children: [
        GestureDetector(
          onTap: () => context.go('/tpa'),
          child: Row(children: [
            const Icon(Icons.arrow_back_ios_rounded, size: 14, color: AppColors.primary),
            const SizedBox(width: 4),
            Text('TPA List',
                style: GoogleFonts.inter(
                    fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w500)),
          ]),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.chevron_right, size: 16, color: AppColors.textLight),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TPA Management › ${tpa.name}',
                  style: GoogleFonts.inter(
                      fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500)),
              Text('Insurance Companies',
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark)),
            ],
          ),
        ),
        Consumer<TpaProvider>(
          builder: (_, p, __) => _AddButton(
            isOpen: p.showAddCompany,
            label: p.showAddCompany ? 'Close' : 'Add Company',
            onTap: () => _handleAddTap(context, provider),
          ),
        ),
      ]),
    );
  }

  void _handleAddTap(BuildContext context, TpaProvider provider) {
    if (ResponsiveHelper.isDesktop(context)) {
      provider.toggleAddCompany();
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ChangeNotifierProvider.value(
          value: provider,
          child: _AddCompanySheet(tpaId: tpaId),
        ),
      );
    }
  }
}

class _AddButton extends StatelessWidget {
  final bool isOpen;
  final String label;
  final VoidCallback onTap;
  const _AddButton({required this.isOpen, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(isOpen ? Icons.close : Icons.add, size: 15),
      label: Text(label,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  COMPANY CONTENT  (TPA info card + list/table)
// ════════════════════════════════════════════════════════════
class _CompanyContent extends StatelessWidget {
  final TpaModel tpa;
  final String tpaId;
  const _CompanyContent({required this.tpa, required this.tpaId});

  @override
  Widget build(BuildContext context) {
    final padding   = ResponsiveHelper.pagePadding(context);
    final isMobile  = ResponsiveHelper.isMobile(context);
    final companies = context.watch<TpaProvider>().companiesForTpa(tpaId);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── TPA Info Card ──────────────────────────────────────
        _TpaInfoCard(tpa: tpa, isMobile: isMobile),
        const SizedBox(height: 16),

        // ── Companies ──────────────────────────────────────────
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(children: [
              // Header row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.border))),
                child: Row(children: [
                  Expanded(
                    child: Text('Insurance Companies under ${tpa.name}',
                        style: GoogleFonts.inter(
                            fontSize: 13, fontWeight: FontWeight.w600,
                            color: AppColors.textDark),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 8),
                  _tagChip('${companies.length} Total', AppColors.primary),
                  const SizedBox(width: 6),
                  if (!isMobile)
                    _tagChip(
                        '${companies.where((c) => c.isActive).length} Active',
                        AppColors.primary),
                ]),
              ),

              // Content
              Expanded(
                child: companies.isEmpty
                    ? Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.business_outlined, size: 40, color: AppColors.textLight),
                    const SizedBox(height: 10),
                    Text('No insurance companies yet',
                        style: GoogleFonts.inter(color: AppColors.textLight)),
                  ]),
                )
                    : ResponsiveLayout(
                  desktop: _CompanyTable(companies: companies, tpaId: tpaId, mode: _TableMode.full),
                  tablet:  _CompanyTable(companies: companies, tpaId: tpaId, mode: _TableMode.compact),
                  mobile:  _CompanyCardList(companies: companies, tpaId: tpaId),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ── TPA Info Card ─────────────────────────────────────────────
class _TpaInfoCard extends StatelessWidget {
  final TpaModel tpa;
  final bool isMobile;
  const _TpaInfoCard({required this.tpa, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(children: [
        Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.business_rounded, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(tpa.name,
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
                maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(
              isMobile
                  ? 'Code: ${tpa.code}  ·  ${tpa.city}'
                  : 'Code: ${tpa.code}  ·  ${tpa.city}  ·  ${tpa.contactPerson}',
              style: GoogleFonts.inter(fontSize: 12, color: AppColors.textLight),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
        const SizedBox(width: 8),
        _activeBadge(tpa.isActive),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  COMPANY TABLE  (desktop = 8 cols, tablet = 5 cols)
// ════════════════════════════════════════════════════════════
enum _TableMode { full, compact }

class _CompanyTable extends StatelessWidget {
  final List<InsuranceCompanyModel> companies;
  final String tpaId;
  final _TableMode mode;
  const _CompanyTable({required this.companies, required this.tpaId, required this.mode});

  bool get _full => mode == _TableMode.full;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Header
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(children: [
          _hCell('COMPANY NAME', 3),
          _hCell('POLICY', 1),
          if (_full) _hCell('EMP. NO', 1),
          if (_full) _hCell('CONTACT', 2),
          if (_full) _hCell('PHONE', 2),
          _hCell('PATIENTS', 1),
          _hCell('STATUS', 1),
          _hCell('', 1),
        ]),
      ),
      // Rows
      Expanded(
        child: ListView.separated(
          itemCount: companies.length,
          separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0xFFF1F3F5)),
          itemBuilder: (ctx, i) =>
              _CompanyRow(company: companies[i], tpaId: tpaId, mode: mode),
        ),
      ),
    ]);
  }
}

class _CompanyRow extends StatelessWidget {
  final InsuranceCompanyModel company;
  final String tpaId;
  final _TableMode mode;
  const _CompanyRow({required this.company, required this.tpaId, required this.mode});

  bool get _full => mode == _TableMode.full;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/tpa/$tpaId/companies/${company.id}/patients'),
      hoverColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(children: [
          Expanded(flex: 3, child: Row(children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                  color: const Color(0xFF1565C0).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(7)),
              child: const Icon(Icons.verified_user_rounded,
                  size: 14, color: Color(0xFF1565C0)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(company.name,
                  style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ])),
          Expanded(flex: 1, child: _policyChip(company.policyType)),
          if (_full) Expanded(flex: 1, child: Text(company.empanelmentNo, style: _cell, maxLines: 1, overflow: TextOverflow.ellipsis)),
          if (_full) Expanded(flex: 2, child: Text(company.contactPerson,  style: _cell, maxLines: 1, overflow: TextOverflow.ellipsis)),
          if (_full) Expanded(flex: 2, child: Text(company.phone,          style: _cell)),
          Expanded(flex: 1, child: Text('${company.patientCount}',
              style: GoogleFonts.inter(
                  fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary))),
          Expanded(flex: 1, child: _activeBadge(company.isActive)),
          Expanded(flex: 1, child: Row(children: [
            IconButton(
              icon: const Icon(Icons.people_rounded, size: 15, color: AppColors.primary),
              onPressed: () =>
                  context.go('/tpa/$tpaId/companies/${company.id}/patients'),
              tooltip: 'View Patients',
              padding: EdgeInsets.zero, constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 6),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 14, color: AppColors.textLight),
              onPressed: () {},
              tooltip: 'Edit',
              padding: EdgeInsets.zero, constraints: const BoxConstraints(),
            ),
          ])),
        ]),
      ),
    );
  }

  TextStyle get _cell => GoogleFonts.inter(fontSize: 12, color: AppColors.textMid);

  Widget _policyChip(String type) {
    final colors = {
      'Group':      AppColors.primary,
      'Corporate':  const Color(0xFF1565C0),
      'Individual': const Color(0xFFDD6B20),
    };
    final c = colors[type] ?? AppColors.textMid;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
          color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Text(type,
          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: c)),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  MOBILE CARD LIST
// ════════════════════════════════════════════════════════════
class _CompanyCardList extends StatelessWidget {
  final List<InsuranceCompanyModel> companies;
  final String tpaId;
  const _CompanyCardList({required this.companies, required this.tpaId});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: companies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) => _CompanyCard(company: companies[i], tpaId: tpaId),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  final InsuranceCompanyModel company;
  final String tpaId;
  const _CompanyCard({required this.company, required this.tpaId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/tpa/$tpaId/companies/${company.id}/patients'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(children: [
          // Icon
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
                color: const Color(0xFF1565C0).withOpacity(0.08),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.verified_user_rounded,
                size: 20, color: Color(0xFF1565C0)),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text(company.name,
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 8),
                _activeBadge(company.isActive),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                _policyChip(company.policyType),
                const SizedBox(width: 8),
                const Icon(Icons.people_outline, size: 11, color: AppColors.textLight),
                const SizedBox(width: 3),
                Text('${company.patientCount} patients',
                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight)),
              ]),
              if (company.contactPerson.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(company.contactPerson,
                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMid),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ]),
          ),

          // Arrow
          const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textLight),
        ]),
      ),
    );
  }

  Widget _policyChip(String type) {
    final colors = {
      'Group':      AppColors.primary,
      'Corporate':  const Color(0xFF1565C0),
      'Individual': const Color(0xFFDD6B20),
    };
    final c = colors[type] ?? AppColors.textMid;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Text(type,
          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: c)),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  DESKTOP SIDE PANEL
// ════════════════════════════════════════════════════════════
class _AddCompanyPanel extends StatelessWidget {
  final String tpaId;
  const _AddCompanyPanel({required this.tpaId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(left: BorderSide(color: AppColors.border)),
      ),
      child: _AddCompanyFormBody(
        tpaId: tpaId,
        onClose: () => context.read<TpaProvider>().closeAddCompany(),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  MOBILE/TABLET BOTTOM SHEET
// ════════════════════════════════════════════════════════════
class _AddCompanySheet extends StatelessWidget {
  final String tpaId;
  const _AddCompanySheet({required this.tpaId});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (ctx, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 36, height: 4,
              decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          Expanded(
            child: _AddCompanyFormBody(
              tpaId: tpaId,
              scrollController: scrollCtrl,
              onClose: () => Navigator.of(context).pop(),
            ),
          ),
        ]),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  SHARED ADD FORM BODY
// ════════════════════════════════════════════════════════════
class _AddCompanyFormBody extends StatefulWidget {
  final String tpaId;
  final VoidCallback onClose;
  final ScrollController? scrollController;
  const _AddCompanyFormBody({
    required this.tpaId,
    required this.onClose,
    this.scrollController,
  });

  @override
  State<_AddCompanyFormBody> createState() => _AddCompanyFormBodyState();
}

class _AddCompanyFormBodyState extends State<_AddCompanyFormBody> {
  final _nameCtrl   = TextEditingController();
  final _typeCtrl   = TextEditingController();
  final _empCtrl    = TextEditingController();
  final _personCtrl = TextEditingController();
  final _phoneCtrl  = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose(); _typeCtrl.dispose(); _empCtrl.dispose();
    _personCtrl.dispose(); _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TpaProvider>();

    return Column(children: [
      // Header
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border))),
        child: Row(children: [
          Text('Add Insurance Company',
              style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textDark)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: widget.onClose,
            padding: EdgeInsets.zero, constraints: const BoxConstraints(),
          ),
        ]),
      ),

      // Fields
      Expanded(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _field('Company Name *',  _nameCtrl,   'e.g. Star Health'),
            _field('Policy Type',     _typeCtrl,   'Group / Corporate / Individual'),
            _field('Emplacement No.', _empCtrl,    'EMP001'),
            _field('Contact Person',  _personCtrl, 'Full name'),
            _field('Phone',           _phoneCtrl,  '10-digit number'),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameCtrl.text.isEmpty) return;
                  provider.addCompany(
                    tpaId:         widget.tpaId,
                    name:          _nameCtrl.text,
                    policyType:    _typeCtrl.text.isEmpty ? 'Group' : _typeCtrl.text,
                    empanelmentNo: _empCtrl.text,
                    contactPerson: _personCtrl.text,
                    phone:         _phoneCtrl.text,
                  );
                  widget.onClose();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Save Company',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
          ]),
        ),
      ),
    ]);
  }
}

// ════════════════════════════════════════════════════════════
//  SHARED HELPERS
// ════════════════════════════════════════════════════════════
Widget _hCell(String t, int flex) => Expanded(
  flex: flex,
  child: Text(t,
      style: GoogleFonts.inter(
          fontSize: 10, fontWeight: FontWeight.w700,
          color: AppColors.textLight, letterSpacing: 0.8)),
);

Widget _activeBadge(bool active) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
  decoration: BoxDecoration(
    color: active
        ? AppColors.primary.withOpacity(0.10)
        : AppColors.textLight.withOpacity(0.12),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(active ? 'Active' : 'Inactive',
      style: GoogleFonts.inter(
          fontSize: 10, fontWeight: FontWeight.w600,
          color: active ? AppColors.primary : AppColors.textLight)),
);

Widget _tagChip(String label, Color c) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
  decoration: BoxDecoration(
      color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
  child: Text(label,
      style: GoogleFonts.inter(fontSize: 11, color: c, fontWeight: FontWeight.w600)),
);

Widget _field(String label, TextEditingController ctrl, String hint) => Padding(
  padding: const EdgeInsets.only(bottom: 14),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label,
        style: GoogleFonts.inter(
            fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
    const SizedBox(height: 5),
    TextField(
      controller: ctrl,
      style: GoogleFonts.inter(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textLight),
        filled: true, fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      ),
    ),
  ]),
);