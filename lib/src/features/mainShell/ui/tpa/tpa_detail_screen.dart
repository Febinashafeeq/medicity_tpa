import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../services/tpa_provider.dart';
import '../../models/models.dart';


class TpaDetailScreen extends StatelessWidget {
  final String tpaId;
  const TpaDetailScreen({super.key, required this.tpaId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TpaProvider>().fetchTpas();
    });
    return _TpaDetailView(tpaId: tpaId);
  }
}

class _TpaDetailView extends StatelessWidget {
  final String tpaId;
  const _TpaDetailView({required this.tpaId});

  @override
  Widget build(BuildContext context) {
    final tpa = context.watch<TpaProvider>().tpaById(tpaId);

    if (tpa == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF0B833D)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(children: [
        _TopBar(tpa: tpa),
        Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: _CompanyContent(tpa: tpa, tpaId: tpaId)),
          Consumer<TpaProvider>(
            builder: (_, p, __) => p.showAddCompany ? _AddCompanyForm(tpaId: tpaId) : const SizedBox.shrink(),
          ),
        ])),
      ]),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final TpaModel tpa;
  const _TopBar({required this.tpa});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TpaProvider>();
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Row(children: [
        InkWell(
          onTap: () => context.go('/tpa'),
          child: Row(children: [
            const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
            const SizedBox(width: 4),
            Text('TPA List', style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
          ]),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.chevron_right, size: 16, color: Color(0xFFADB5BD)),
        const SizedBox(width: 8),
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('TPA Management › ${tpa.name}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
          Text('Insurance Companies', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
        ]),
        const Spacer(),
        Consumer<TpaProvider>(
          builder: (_, p, __) => ElevatedButton.icon(
            onPressed: provider.toggleAddCompany,
            icon: Icon(p.showAddCompany ? Icons.close : Icons.add, size: 16),
            label: Text(
              p.showAddCompany ? 'Close' : 'Add Company',
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

// ── Company Content ───────────────────────────────────────────────────────────
class _CompanyContent extends StatelessWidget {
  final TpaModel tpa;
  final String tpaId;
  const _CompanyContent({required this.tpa, required this.tpaId});

  @override
  Widget build(BuildContext context) {
    final provider  = context.watch<TpaProvider>();
    final companies = provider.companiesForTpa(tpaId);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // TPA Info Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE9ECEF))),
          child: Row(children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: const Color(0xFF0B833D).withOpacity(0.10), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.business_rounded, color: Color(0xFF0B833D), size: 20),
            ),
            const SizedBox(width: 14),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(tpa.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
              Text('Code: ${tpa.code}  ·  ${tpa.city}  ·  ${tpa.contactPerson}',
                  style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD))),
            ]),
            const Spacer(),
            _activeBadge(tpa.isActive),
          ]),
        ),
        const SizedBox(height: 20),

        // Companies Table
        Expanded(child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE9ECEF))),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
              child: Row(children: [
                Text('Insurance Companies under ${tpa.name}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                const Spacer(),
                _tagChip('${companies.length} Total', const Color(0xFF0B833D)),
                const SizedBox(width: 8),
                _tagChip('${companies.where((c) => c.isActive).length} Active', const Color(0xFF0B833D)),
              ]),
            ),
            _tableHeader(),
            Expanded(child: companies.isEmpty
                ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.business_outlined, size: 40, color: Color(0xFFADB5BD)),
              const SizedBox(height: 10),
              Text('No insurance companies yet', style: GoogleFonts.inter(color: const Color(0xFFADB5BD))),
            ]))
                : ListView.separated(
              itemCount: companies.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
              itemBuilder: (ctx, i) => _CompanyRow(company: companies[i], tpaId: tpaId),
            )),
          ]),
        )),
      ]),
    );
  }

  Widget _tableHeader() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
    decoration: const BoxDecoration(color: Color(0xFFF8F9FA), border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
    child: Row(children: [
      _hCell('COMPANY NAME', 3), _hCell('POLICY TYPE', 1), _hCell('EMP. NO', 1),
      _hCell('CONTACT', 2),      _hCell('PHONE', 2),       _hCell('PATIENTS', 1),
      _hCell('STATUS', 1),       _hCell('ACTION', 1),
    ]),
  );
}

// ── Company Row ───────────────────────────────────────────────────────────────
class _CompanyRow extends StatelessWidget {
  final InsuranceCompanyModel company;
  final String tpaId;
  const _CompanyRow({required this.company, required this.tpaId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/tpa/$tpaId/companies/${company.id}/patients'),
      hoverColor: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        child: Row(children: [
          Expanded(flex: 3, child: Row(children: [
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(color: const Color(0xFF1565C0).withOpacity(0.08), borderRadius: BorderRadius.circular(7)),
              child: const Icon(Icons.verified_user_rounded, size: 15, color: Color(0xFF1565C0)),
            ),
            const SizedBox(width: 10),
            Text(company.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
          ])),
          Expanded(flex: 1, child: _policyChip(company.policyType)),
          Expanded(flex: 1, child: Text(company.empanelmentNo, style: _cell)),
          Expanded(flex: 2, child: Text(company.contactPerson, style: _cell)),
          Expanded(flex: 2, child: Text(company.phone,         style: _cell)),
          Expanded(flex: 1, child: Text('${company.patientCount}',
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D)))),
          Expanded(flex: 1, child: _activeBadge(company.isActive)),
          Expanded(flex: 1, child: Row(children: [
            IconButton(
              icon: const Icon(Icons.people_rounded, size: 16, color: Color(0xFF0B833D)),
              onPressed: () => context.go('/tpa/$tpaId/companies/${company.id}/patients'),
              tooltip: 'View Patients', padding: EdgeInsets.zero, constraints: const BoxConstraints(),
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

  Widget _policyChip(String type) {
    final colors = {
      'Group':      const Color(0xFF0B833D),
      'Corporate':  const Color(0xFF1565C0),
      'Individual': const Color(0xFFDD6B20),
    };
    final c = colors[type] ?? const Color(0xFF495057);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Text(type, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: c)),
    );
  }
}

// ── Add Company Form ──────────────────────────────────────────────────────────
class _AddCompanyForm extends StatefulWidget {
  final String tpaId;
  const _AddCompanyForm({required this.tpaId});

  @override
  State<_AddCompanyForm> createState() => _AddCompanyFormState();
}

class _AddCompanyFormState extends State<_AddCompanyForm> {
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
            Text('Add Insurance Company', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: provider.closeAddCompany,
              padding: EdgeInsets.zero, constraints: const BoxConstraints(),
            ),
          ]),
        ),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _field('Company Name *',  _nameCtrl,   'e.g. Star Health'),
            _field('Policy Type',     _typeCtrl,   'Group / Corporate / Individual'),
            _field('Empanelment No.', _empCtrl,    'EMP001'),
            _field('Contact Person',  _personCtrl, 'Full name'),
            _field('Phone',           _phoneCtrl,  '10-digit number'),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: ElevatedButton(
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
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Save Company', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            )),
          ]),
        )),
      ]),
    );
  }
}

// ── Shared Helpers ────────────────────────────────────────────────────────────
Widget _hCell(String t, int flex) => Expanded(
  flex: flex,
  child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
);

Widget _activeBadge(bool active) => Container(
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

Widget _tagChip(String label, Color c) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
  child: Text(label, style: GoogleFonts.inter(fontSize: 11, color: c, fontWeight: FontWeight.w600)),
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