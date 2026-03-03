import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../services/tpa_provider.dart';
import '../../../../shared/constants/responsive_helper.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../models/models.dart';


// class TpaListScreen extends StatelessWidget {
//   const TpaListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<TpaProvider>().fetchTpas();
//     });
//     return const _TpaListView();
//   }
// }
//
// class _TpaListView extends StatelessWidget {
//   const _TpaListView();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: Column(children: [
//         const _TopBar(),
//         Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           const Expanded(child: _TpaTable()),
//           Consumer<TpaProvider>(
//             builder: (_, p, __) => p.showAddTpa ? const _AddTpaForm() : const SizedBox.shrink(),
//           ),
//         ])),
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
//     final provider = context.read<TpaProvider>();
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       color: Colors.white,
//       child: Row(children: [
//         Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text('Ledger Management', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
//           Text('TPA Management', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
//         ]),
//         const Spacer(),
//         SizedBox(
//           width: 220, height: 36,
//           child: TextField(
//             onChanged: provider.searchTpa,
//             decoration: _searchDecor('Search TPA...'),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Consumer<TpaProvider>(
//           builder: (_, p, __) => ElevatedButton.icon(
//             onPressed: provider.toggleAddTpa,
//             icon: Icon(p.showAddTpa ? Icons.close : Icons.add, size: 16),
//             label: Text(
//               p.showAddTpa ? 'Close' : 'Add TPA',
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
// // ── TPA Table ─────────────────────────────────────────────────────────────────
// class _TpaTable extends StatelessWidget {
//   const _TpaTable();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: const Color(0xFFE9ECEF)),
//         ),
//         child: Column(children: [
//           Consumer<TpaProvider>(
//             builder: (_, p, __) => Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
//               child: Row(children: [
//                 _chip('Total',    '${p.totalTpas}',   const Color(0xFF0B833D)),
//                 const SizedBox(width: 10),
//                 _chip('Active',   '${p.activeTpas}',  const Color(0xFF0B833D)),
//                 const SizedBox(width: 10),
//                 _chip('Inactive', '${p.inactiveTpas}', const Color(0xFFADB5BD)),
//               ]),
//             ),
//           ),
//           _tableHeader(),
//           Expanded(child: Consumer<TpaProvider>(
//             builder: (_, p, __) {
//               if (p.isLoading) {
//                 return const Center(child: CircularProgressIndicator(color: Color(0xFF0B833D)));
//               }
//               if (p.filteredTpas.isEmpty) {
//                 return Center(child: Text('No TPAs found', style: GoogleFonts.inter(color: const Color(0xFFADB5BD))));
//               }
//               return ListView.separated(
//                 itemCount: p.filteredTpas.length,
//                 separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
//                 itemBuilder: (ctx, i) => _TpaRow(tpa: p.filteredTpas[i]),
//               );
//             },
//           )),
//         ]),
//       ),
//     );
//   }
//
//   Widget _tableHeader() => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
//     decoration: const BoxDecoration(
//       color: Color(0xFFF8F9FA),
//       border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF))),
//     ),
//     child: Row(children: [
//       _hCell('TPA NAME', 3), _hCell('CODE', 1), _hCell('CONTACT', 2),
//       _hCell('PHONE', 2),    _hCell('CITY', 1), _hCell('COMPANIES', 1),
//       _hCell('STATUS', 1),   _hCell('ACTION', 1),
//     ]),
//   );
// }
//
// // ── TPA Row ───────────────────────────────────────────────────────────────────
// class _TpaRow extends StatelessWidget {
//   final TpaModel tpa;
//   const _TpaRow({required this.tpa});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => context.go('/tpa/${tpa.id}'),
//       hoverColor: const Color(0xFFF8F9FA),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
//         child: Row(children: [
//           Expanded(flex: 3, child: Row(children: [
//             Container(
//               width: 30, height: 30,
//               decoration: BoxDecoration(color: const Color(0xFF0B833D).withOpacity(0.10), borderRadius: BorderRadius.circular(7)),
//               child: const Icon(Icons.business_rounded, size: 15, color: Color(0xFF0B833D)),
//             ),
//             const SizedBox(width: 10),
//             Text(tpa.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//           ])),
//           Expanded(flex: 1, child: Text(tpa.code,          style: _cell)),
//           Expanded(flex: 2, child: Text(tpa.contactPerson,  style: _cell)),
//           Expanded(flex: 2, child: Text(tpa.phone,          style: _cell)),
//           Expanded(flex: 1, child: Text(tpa.city,           style: _cell)),
//           Expanded(flex: 1, child: Text('${tpa.companyCount} cos',
//               style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0B833D)))),
//           Expanded(flex: 1, child: _statusBadge(tpa.isActive)),
//           Expanded(flex: 1, child: Row(children: [
//             IconButton(
//               icon: const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF0B833D)),
//               onPressed: () => context.go('/tpa/${tpa.id}'),
//               tooltip: 'View', padding: EdgeInsets.zero, constraints: const BoxConstraints(),
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
//   Widget _statusBadge(bool active) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
//     decoration: BoxDecoration(
//       color: active ? const Color(0xFF0B833D).withOpacity(0.10) : const Color(0xFFADB5BD).withOpacity(0.12),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Text(
//       active ? 'Active' : 'Inactive',
//       style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
//           color: active ? const Color(0xFF0B833D) : const Color(0xFFADB5BD)),
//     ),
//   );
// }
//
// // ── Add TPA Form ──────────────────────────────────────────────────────────────
// class _AddTpaForm extends StatefulWidget {
//   const _AddTpaForm();
//
//   @override
//   State<_AddTpaForm> createState() => _AddTpaFormState();
// }
//
// class _AddTpaFormState extends State<_AddTpaForm> {
//   final _nameCtrl   = TextEditingController();
//   final _codeCtrl   = TextEditingController();
//   final _personCtrl = TextEditingController();
//   final _phoneCtrl  = TextEditingController();
//   final _cityCtrl   = TextEditingController();
//
//   @override
//   void dispose() {
//     _nameCtrl.dispose(); _codeCtrl.dispose(); _personCtrl.dispose();
//     _phoneCtrl.dispose(); _cityCtrl.dispose();
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
//             Text('Add New TPA', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
//             const Spacer(),
//             IconButton(
//               icon: const Icon(Icons.close, size: 18),
//               onPressed: provider.closeAddTpa,
//               padding: EdgeInsets.zero, constraints: const BoxConstraints(),
//             ),
//           ]),
//         ),
//         Expanded(child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             _field('TPA Name *',     _nameCtrl,   'e.g. Medi Assist TPA'),
//             _field('TPA Code *',     _codeCtrl,   'e.g. MA001'),
//             _field('Contact Person', _personCtrl, 'Full name'),
//             _field('Phone',          _phoneCtrl,  '10-digit number'),
//             _field('City',           _cityCtrl,   'City name'),
//             const SizedBox(height: 8),
//             SizedBox(width: double.infinity, child: ElevatedButton(
//               onPressed: () {
//                 if (_nameCtrl.text.isEmpty || _codeCtrl.text.isEmpty) return;
//                 provider.addTpa(
//                   name:          _nameCtrl.text,
//                   code:          _codeCtrl.text,
//                   contactPerson: _personCtrl.text,
//                   phone:         _phoneCtrl.text,
//                   city:          _cityCtrl.text,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
//                 padding: const EdgeInsets.symmetric(vertical: 13),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: Text('Save TPA', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
//             )),
//           ]),
//         )),
//       ]),
//     );
//   }
// }
//
// // ── Shared helpers ────────────────────────────────────────────────────────────
// Widget _hCell(String t, int flex) => Expanded(
//   flex: flex,
//   child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
// );
//
// Widget _chip(String label, String val, Color c) => Container(
//   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//   decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
//   child: Row(mainAxisSize: MainAxisSize.min, children: [
//     Text(label, style: GoogleFonts.inter(fontSize: 11, color: c, fontWeight: FontWeight.w500)),
//     const SizedBox(width: 5),
//     Text(val,   style: GoogleFonts.inter(fontSize: 12, color: c, fontWeight: FontWeight.w700)),
//   ]),
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
//
// InputDecoration _searchDecor(String hint) => InputDecoration(
//   hintText: hint,
//   hintStyle: GoogleFonts.inter(fontSize: 13, color: const Color(0xFFADB5BD)),
//   prefixIcon: const Icon(Icons.search, size: 16, color: Color(0xFFADB5BD)),
//   filled: true, fillColor: const Color(0xFFF8F9FA), contentPadding: EdgeInsets.zero,
//   border:        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
//   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
//   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0B833D), width: 1.5)),
// );

/// changed for responsive

// lib/src/features/mainShell/ui/tpa/tpa_list_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
//  RESPONSIVE TPA LIST SCREEN
//  • Desktop  (≥1024px): Full 8-col table + side-panel Add form
//  • Tablet   (600–1023): Condensed 5-col table + modal bottom sheet Add form
//  • Mobile   (<600px):  Card list view       + modal bottom sheet Add form
// ─────────────────────────────────────────────────────────────────────────────



// ════════════════════════════════════════════════════════════
//  ROOT
// ════════════════════════════════════════════════════════════
class TpaListScreen extends StatelessWidget {
  const TpaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TpaProvider>().fetchTpas();
    });
    return const _TpaListView();
  }
}

class _TpaListView extends StatelessWidget {
  const _TpaListView();

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(children: [
        _TopBar(),
        Expanded(
          child: isDesktop
          // Desktop: table + optional side panel
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _TpaContent()),
            Consumer<TpaProvider>(
              builder: (_, p, __) =>
              p.showAddTpa ? const _AddTpaPanel() : const SizedBox.shrink(),
            ),
          ])
          // Tablet/Mobile: just content, form is a bottom sheet
              : _TpaContent(),
        ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  TOP BAR
// ════════════════════════════════════════════════════════════
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider  = context.read<TpaProvider>();
    final isMobile  = ResponsiveHelper.isMobile(context);
    final padding   = ResponsiveHelper.pagePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: isMobile ? 10 : 0),
      constraints: BoxConstraints(minHeight: isMobile ? 56 : 60),
      color: AppColors.white,
      child: isMobile
      // Mobile: two-row layout
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ledger Management',
                      style: GoogleFonts.inter(
                          fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500)),
                  Text('TPA Management',
                      style: GoogleFonts.inter(
                          fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                ],
              ),
            ),
            Consumer<TpaProvider>(
              builder: (_, p, __) => _AddButton(
                isOpen: p.showAddTpa,
                onTap: () => _handleAddTap(context, provider),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          SizedBox(
            height: 36,
            child: TextField(
              onChanged: provider.searchTpa,
              decoration: _searchDecor('Search TPA...'),
            ),
          ),
          const SizedBox(height: 4),
        ],
      )
      // Tablet/Desktop: single row
          : Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ledger Management',
                style: GoogleFonts.inter(
                    fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500)),
            Text('TPA Management',
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark)),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 200, height: 36,
          child: TextField(
            onChanged: provider.searchTpa,
            decoration: _searchDecor('Search TPA...'),
          ),
        ),
        const SizedBox(width: 12),
        Consumer<TpaProvider>(
          builder: (_, p, __) => _AddButton(
            isOpen: p.showAddTpa,
            onTap: () => _handleAddTap(context, provider),
          ),
        ),
      ]),
    );
  }

  /// On desktop: toggle the side panel. On mobile/tablet: open bottom sheet.
  void _handleAddTap(BuildContext context, TpaProvider provider) {
    if (ResponsiveHelper.isDesktop(context)) {
      provider.toggleAddTpa();
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ChangeNotifierProvider.value(
          value: provider,
          child: const _AddTpaSheet(),
        ),
      );
    }
  }
}

class _AddButton extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onTap;
  const _AddButton({required this.isOpen, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(isOpen ? Icons.close : Icons.add, size: 16),
      label: Text(
        isOpen ? 'Close' : 'Add TPA',
        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
      ),
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
//  CONTENT SWITCHER
// ════════════════════════════════════════════════════════════
class _TpaContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktop: const _TpaTable(mode: _TableMode.full),
      tablet:  const _TpaTable(mode: _TableMode.compact),
      mobile:  const _TpaCardList(),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  TABLE  (desktop = full 8 cols, tablet = 5 cols)
// ════════════════════════════════════════════════════════════
enum _TableMode { full, compact }

class _TpaTable extends StatelessWidget {
  final _TableMode mode;
  const _TpaTable({required this.mode});

  bool get _full => mode == _TableMode.full;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(children: [
          // ── Stats chips ─────────────────────────────────────
          Consumer<TpaProvider>(
            builder: (_, p, __) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border))),
              child: Row(children: [
                _chip('Total',    '${p.totalTpas}',   AppColors.primary),
                const SizedBox(width: 8),
                _chip('Active',   '${p.activeTpas}',  AppColors.primary),
                const SizedBox(width: 8),
                _chip('Inactive', '${p.inactiveTpas}', AppColors.textLight),
              ]),
            ),
          ),

          // ── Header ──────────────────────────────────────────
          _tableHeader(),

          // ── Rows ────────────────────────────────────────────
          Expanded(child: Consumer<TpaProvider>(
            builder: (_, p, __) {
              if (p.isLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary));
              }
              if (p.filteredTpas.isEmpty) {
                return Center(
                    child: Text('No TPAs found',
                        style: GoogleFonts.inter(color: AppColors.textLight)));
              }
              return ListView.separated(
                itemCount: p.filteredTpas.length,
                separatorBuilder: (_, __) =>
                const Divider(height: 1, color: Color(0xFFF1F3F5)),
                itemBuilder: (ctx, i) =>
                    _TpaRow(tpa: p.filteredTpas[i], mode: mode),
              );
            },
          )),
        ]),
      ),
    );
  }

  Widget _tableHeader() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: const BoxDecoration(
      color: AppColors.surface,
      border: Border(bottom: BorderSide(color: AppColors.border)),
    ),
    child: Row(children: [
      _hCell('TPA NAME', 3),
      _hCell('CODE', 1),
      if (_full) _hCell('CONTACT', 2),
      if (_full) _hCell('PHONE', 2),
      _hCell('CITY', 1),
      _hCell('COS', 1),
      _hCell('STATUS', 1),
      _hCell('', 1),
    ]),
  );
}

// ── Table Row ─────────────────────────────────────────────────
class _TpaRow extends StatelessWidget {
  final TpaModel tpa;
  final _TableMode mode;
  const _TpaRow({required this.tpa, required this.mode});

  bool get _full => mode == _TableMode.full;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/tpa/${tpa.id}'),
      hoverColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(children: [
          // Name
          Expanded(flex: 3, child: Row(children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(7)),
              child: const Icon(Icons.business_rounded, size: 14, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(tpa.name,
                  style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ])),
          Expanded(flex: 1, child: Text(tpa.code, style: _cell)),
          if (_full) Expanded(flex: 2, child: Text(tpa.contactPerson, style: _cell, maxLines: 1, overflow: TextOverflow.ellipsis)),
          if (_full) Expanded(flex: 2, child: Text(tpa.phone, style: _cell)),
          Expanded(flex: 1, child: Text(tpa.city, style: _cell, maxLines: 1, overflow: TextOverflow.ellipsis)),
          Expanded(flex: 1, child: Text('${tpa.companyCount}',
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary))),
          Expanded(flex: 1, child: _statusBadge(tpa.isActive)),
          Expanded(flex: 1, child: Row(children: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_rounded, size: 15, color: AppColors.primary),
              onPressed: () => context.go('/tpa/${tpa.id}'),
              tooltip: 'View', padding: EdgeInsets.zero, constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 6),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 14, color: AppColors.textLight),
              onPressed: () {},
              tooltip: 'Edit', padding: EdgeInsets.zero, constraints: const BoxConstraints(),
            ),
          ])),
        ]),
      ),
    );
  }

  TextStyle get _cell => GoogleFonts.inter(fontSize: 12, color: AppColors.textMid);

  Widget _statusBadge(bool active) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: active
          ? AppColors.primary.withOpacity(0.10)
          : AppColors.textLight.withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(active ? 'Active' : 'Inactive',
        style: GoogleFonts.inter(
            fontSize: 11, fontWeight: FontWeight.w600,
            color: active ? AppColors.primary : AppColors.textLight)),
  );
}

// ════════════════════════════════════════════════════════════
//  MOBILE CARD LIST
// ════════════════════════════════════════════════════════════
class _TpaCardList extends StatelessWidget {
  const _TpaCardList();

  @override
  Widget build(BuildContext context) {
    return Consumer<TpaProvider>(builder: (_, p, __) {
      if (p.isLoading) {
        return const Center(child: CircularProgressIndicator(color: AppColors.primary));
      }
      if (p.filteredTpas.isEmpty) {
        return Center(
            child: Text('No TPAs found',
                style: GoogleFonts.inter(color: AppColors.textLight)));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: p.filteredTpas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) => _TpaCard(tpa: p.filteredTpas[i]),
      );
    });
  }
}

class _TpaCard extends StatelessWidget {
  final TpaModel tpa;
  const _TpaCard({required this.tpa});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/tpa/${tpa.id}'),
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
            width: 42, height: 42,
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.business_rounded, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text(tpa.name,
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 8),
                _statusBadge(tpa.isActive),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                Text(tpa.code,
                    style: GoogleFonts.inter(
                        fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                const SizedBox(width: 10),
                const Icon(Icons.location_on_outlined, size: 11, color: AppColors.textLight),
                const SizedBox(width: 2),
                Text(tpa.city,
                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight)),
                const SizedBox(width: 10),
                const Icon(Icons.business_center_outlined, size: 11, color: AppColors.textLight),
                const SizedBox(width: 2),
                Text('${tpa.companyCount} cos',
                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight)),
              ]),
              if (tpa.contactPerson.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(tpa.contactPerson,
                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMid),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ]),
          ),

          // Chevron
          const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textLight),
        ]),
      ),
    );
  }

  Widget _statusBadge(bool active) => Container(
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
}

// ════════════════════════════════════════════════════════════
//  DESKTOP SIDE PANEL
// ════════════════════════════════════════════════════════════
class _AddTpaPanel extends StatelessWidget {
  const _AddTpaPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(left: BorderSide(color: AppColors.border)),
      ),
      child: _AddTpaFormBody(
        onClose: () => context.read<TpaProvider>().closeAddTpa(),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  MOBILE/TABLET BOTTOM SHEET
// ════════════════════════════════════════════════════════════
class _AddTpaSheet extends StatelessWidget {
  const _AddTpaSheet();

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
          // Drag handle
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
            child: _AddTpaFormBody(
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
class _AddTpaFormBody extends StatefulWidget {
  final VoidCallback onClose;
  final ScrollController? scrollController;
  const _AddTpaFormBody({required this.onClose, this.scrollController});

  @override
  State<_AddTpaFormBody> createState() => _AddTpaFormBodyState();
}

class _AddTpaFormBodyState extends State<_AddTpaFormBody> {
  final _nameCtrl   = TextEditingController();
  final _codeCtrl   = TextEditingController();
  final _personCtrl = TextEditingController();
  final _phoneCtrl  = TextEditingController();
  final _cityCtrl   = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose(); _codeCtrl.dispose(); _personCtrl.dispose();
    _phoneCtrl.dispose(); _cityCtrl.dispose();
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
          Text('Add New TPA',
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
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
            _field('TPA Name *',     _nameCtrl,   'e.g. Medi Assist TPA'),
            _field('TPA Code *',     _codeCtrl,   'e.g. MA001'),
            _field('Contact Person', _personCtrl, 'Full name'),
            _field('Phone',          _phoneCtrl,  '10-digit number'),
            _field('City',           _cityCtrl,   'City name'),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameCtrl.text.isEmpty || _codeCtrl.text.isEmpty) return;
                  provider.addTpa(
                    name:          _nameCtrl.text,
                    code:          _codeCtrl.text,
                    contactPerson: _personCtrl.text,
                    phone:         _phoneCtrl.text,
                    city:          _cityCtrl.text,
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
                child: Text('Save TPA',
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

Widget _chip(String label, String val, Color c) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  decoration: BoxDecoration(
      color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
  child: Row(mainAxisSize: MainAxisSize.min, children: [
    Text(label,
        style: GoogleFonts.inter(fontSize: 11, color: c, fontWeight: FontWeight.w500)),
    const SizedBox(width: 5),
    Text(val,
        style: GoogleFonts.inter(fontSize: 12, color: c, fontWeight: FontWeight.w700)),
  ]),
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

InputDecoration _searchDecor(String hint) => InputDecoration(
  hintText: hint,
  hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textLight),
  prefixIcon: const Icon(Icons.search, size: 16, color: AppColors.textLight),
  filled: true, fillColor: AppColors.surface,
  contentPadding: EdgeInsets.zero,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.border)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.border)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
);