import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../services/tpa_provider.dart';
import '../../models/models.dart';


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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(children: [
        const _TopBar(),
        Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Expanded(child: _TpaTable()),
          Consumer<TpaProvider>(
            builder: (_, p, __) => p.showAddTpa ? const _AddTpaForm() : const SizedBox.shrink(),
          ),
        ])),
      ]),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TpaProvider>();
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Row(children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Ledger Management', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
          Text('TPA Management', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
        ]),
        const Spacer(),
        SizedBox(
          width: 220, height: 36,
          child: TextField(
            onChanged: provider.searchTpa,
            decoration: _searchDecor('Search TPA...'),
          ),
        ),
        const SizedBox(width: 12),
        Consumer<TpaProvider>(
          builder: (_, p, __) => ElevatedButton.icon(
            onPressed: provider.toggleAddTpa,
            icon: Icon(p.showAddTpa ? Icons.close : Icons.add, size: 16),
            label: Text(
              p.showAddTpa ? 'Close' : 'Add TPA',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ]),
    );
  }
}

// ── TPA Table ─────────────────────────────────────────────────────────────────
class _TpaTable extends StatelessWidget {
  const _TpaTable();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE9ECEF)),
        ),
        child: Column(children: [
          Consumer<TpaProvider>(
            builder: (_, p, __) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
              child: Row(children: [
                _chip('Total',    '${p.totalTpas}',   const Color(0xFF0B833D)),
                const SizedBox(width: 10),
                _chip('Active',   '${p.activeTpas}',  const Color(0xFF0B833D)),
                const SizedBox(width: 10),
                _chip('Inactive', '${p.inactiveTpas}', const Color(0xFFADB5BD)),
              ]),
            ),
          ),
          _tableHeader(),
          Expanded(child: Consumer<TpaProvider>(
            builder: (_, p, __) {
              if (p.isLoading) {
                return const Center(child: CircularProgressIndicator(color: Color(0xFF0B833D)));
              }
              if (p.filteredTpas.isEmpty) {
                return Center(child: Text('No TPAs found', style: GoogleFonts.inter(color: const Color(0xFFADB5BD))));
              }
              return ListView.separated(
                itemCount: p.filteredTpas.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
                itemBuilder: (ctx, i) => _TpaRow(tpa: p.filteredTpas[i]),
              );
            },
          )),
        ]),
      ),
    );
  }

  Widget _tableHeader() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
    decoration: const BoxDecoration(
      color: Color(0xFFF8F9FA),
      border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF))),
    ),
    child: Row(children: [
      _hCell('TPA NAME', 3), _hCell('CODE', 1), _hCell('CONTACT', 2),
      _hCell('PHONE', 2),    _hCell('CITY', 1), _hCell('COMPANIES', 1),
      _hCell('STATUS', 1),   _hCell('ACTION', 1),
    ]),
  );
}

// ── TPA Row ───────────────────────────────────────────────────────────────────
class _TpaRow extends StatelessWidget {
  final TpaModel tpa;
  const _TpaRow({required this.tpa});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/tpa/${tpa.id}'),
      hoverColor: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        child: Row(children: [
          Expanded(flex: 3, child: Row(children: [
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(color: const Color(0xFF0B833D).withOpacity(0.10), borderRadius: BorderRadius.circular(7)),
              child: const Icon(Icons.business_rounded, size: 15, color: Color(0xFF0B833D)),
            ),
            const SizedBox(width: 10),
            Text(tpa.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
          ])),
          Expanded(flex: 1, child: Text(tpa.code,          style: _cell)),
          Expanded(flex: 2, child: Text(tpa.contactPerson,  style: _cell)),
          Expanded(flex: 2, child: Text(tpa.phone,          style: _cell)),
          Expanded(flex: 1, child: Text(tpa.city,           style: _cell)),
          Expanded(flex: 1, child: Text('${tpa.companyCount} cos',
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0B833D)))),
          Expanded(flex: 1, child: _statusBadge(tpa.isActive)),
          Expanded(flex: 1, child: Row(children: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF0B833D)),
              onPressed: () => context.go('/tpa/${tpa.id}'),
              tooltip: 'View', padding: EdgeInsets.zero, constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 15, color: Color(0xFFADB5BD)),
              onPressed: () {},
              tooltip: 'Edit', padding: EdgeInsets.zero, constraints: const BoxConstraints(),
            ),
          ])),
        ]),
      ),
    );
  }

  TextStyle get _cell => GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057));

  Widget _statusBadge(bool active) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(
      color: active ? const Color(0xFF0B833D).withOpacity(0.10) : const Color(0xFFADB5BD).withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      active ? 'Active' : 'Inactive',
      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
          color: active ? const Color(0xFF0B833D) : const Color(0xFFADB5BD)),
    ),
  );
}

// ── Add TPA Form ──────────────────────────────────────────────────────────────
class _AddTpaForm extends StatefulWidget {
  const _AddTpaForm();

  @override
  State<_AddTpaForm> createState() => _AddTpaFormState();
}

class _AddTpaFormState extends State<_AddTpaForm> {
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
    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Color(0xFFE9ECEF))),
      ),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
          child: Row(children: [
            Text('Add New TPA', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: provider.closeAddTpa,
              padding: EdgeInsets.zero, constraints: const BoxConstraints(),
            ),
          ]),
        ),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _field('TPA Name *',     _nameCtrl,   'e.g. Medi Assist TPA'),
            _field('TPA Code *',     _codeCtrl,   'e.g. MA001'),
            _field('Contact Person', _personCtrl, 'Full name'),
            _field('Phone',          _phoneCtrl,  '10-digit number'),
            _field('City',           _cityCtrl,   'City name'),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () {
                if (_nameCtrl.text.isEmpty || _codeCtrl.text.isEmpty) return;
                provider.addTpa(
                  name:          _nameCtrl.text,
                  code:          _codeCtrl.text,
                  contactPerson: _personCtrl.text,
                  phone:         _phoneCtrl.text,
                  city:          _cityCtrl.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Save TPA', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            )),
          ]),
        )),
      ]),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────
Widget _hCell(String t, int flex) => Expanded(
  flex: flex,
  child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
);

Widget _chip(String label, String val, Color c) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
  child: Row(mainAxisSize: MainAxisSize.min, children: [
    Text(label, style: GoogleFonts.inter(fontSize: 11, color: c, fontWeight: FontWeight.w500)),
    const SizedBox(width: 5),
    Text(val,   style: GoogleFonts.inter(fontSize: 12, color: c, fontWeight: FontWeight.w700)),
  ]),
);

Widget _field(String label, TextEditingController ctrl, String hint) => Padding(
  padding: const EdgeInsets.only(bottom: 14),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
    const SizedBox(height: 5),
    TextField(
      controller: ctrl,
      style: GoogleFonts.inter(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 13, color: const Color(0xFFADB5BD)),
        filled: true, fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border:        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0B833D), width: 1.5)),
      ),
    ),
  ]),
);

InputDecoration _searchDecor(String hint) => InputDecoration(
  hintText: hint,
  hintStyle: GoogleFonts.inter(fontSize: 13, color: const Color(0xFFADB5BD)),
  prefixIcon: const Icon(Icons.search, size: 16, color: Color(0xFFADB5BD)),
  filled: true, fillColor: const Color(0xFFF8F9FA), contentPadding: EdgeInsets.zero,
  border:        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0B833D), width: 1.5)),
);