import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../services/insurance_provider.dart';
import '../../../../services/patients_provider.dart';
import '../../../../services/tpa_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';


class PatientListScreen extends StatelessWidget {
  final String tpaId;
  final String companyId;

  const PatientListScreen({
    super.key,
    required this.tpaId,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => InsuranceProvider()),
        ChangeNotifierProvider(create: (_) => TpaProvider()),
      ],
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<TpaProvider>().fetchTpas();
            context.read<TpaProvider>().fetchCompanies(tpaId: tpaId);
            // context.read<PatientProvider>().fetchPatients(companyId: companyId);
          });

          return _PatientListView(
            tpaId: tpaId,
            companyId: companyId,
          );
        },
      ),
    );
  }
}
class _PatientListView extends StatelessWidget {
  final String tpaId;
  final String companyId;
  const _PatientListView({required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(children: [
        _TopBar(tpaId: tpaId, companyId: companyId),
        Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: _PatientContent(tpaId: tpaId, companyId: companyId)),
          Consumer<PatientProvider>(
            builder: (_, p, __) => p.showAddPatient ? const _AddPatientForm() : const SizedBox.shrink(),
          ),
        ])),
      ]),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final String tpaId;
  final String companyId;
  const _TopBar({required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final tpaProvider   = context.read<TpaProvider>();
    final insProvider   = context.read<InsuranceProvider>();
    final patProvider   = context.read<PatientProvider>();
    final tpa = tpaProvider.tpaById(tpaId);
    final company       = tpaProvider.getCompanyById(companyId);

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Row(children: [
        InkWell(
          onTap: () => context.go('/tpa/$tpaId'),
          child: Row(children: [
            const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
            const SizedBox(width: 4),
            Text(tpa?.name ?? '', style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
          ]),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, size: 16, color: Color(0xFFADB5BD)),
        const SizedBox(width: 4),
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${tpa?.name ?? ''} › ${company?.name ?? ''}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
          Text('Daily Collections', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
        ]),
        const Spacer(),
        Consumer<PatientProvider>(
          builder: (_, p, __) => InkWell(
            onTap: () async {
              final d = await showDatePicker(
                context: context, initialDate: p.selectedDate,
                firstDate: DateTime(2020), lastDate: DateTime.now(),
                builder: (ctx, child) => Theme(data: ThemeData(colorSchemeSeed: const Color(0xFF0B833D)), child: child!),
              );
              if (d != null) patProvider.setDate(d);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE9ECEF))),
              child: Row(children: [
                const Icon(Icons.calendar_today_rounded, size: 15, color: Color(0xFF0B833D)),
                const SizedBox(width: 8),
                Text(_fmt(p.selectedDate), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
              ]),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Consumer<PatientProvider>(
          builder: (_, p, __) => ElevatedButton.icon(
            onPressed: patProvider.toggleAddPatient,
            icon: Icon(p.showAddPatient ? Icons.close : Icons.person_add_rounded, size: 16),
            label: Text(p.showAddPatient ? 'Close' : 'Add Patient', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
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

// ── Patient Content ───────────────────────────────────────────────────────────
class _PatientContent extends StatelessWidget {
  final String tpaId;
  final String companyId;
  const _PatientContent({required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final patProvider = context.watch<PatientProvider>();
    final patients    = patProvider.patientsForCompany(companyId);
    final summary     = patProvider.summaryForCompany(companyId);
    final collections = patProvider.collectionsForCompanyOnDate(companyId);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          _SummaryCard(label: 'Total Patients', value: '${patients.length}', icon: Icons.people_rounded, color: const Color(0xFF1565C0)),
          const SizedBox(width: 12),
          _SummaryCard(label: "Today's Collections", value: '${summary.total}', icon: Icons.biotech_rounded, color: const Color(0xFF0B833D)),
          const SizedBox(width: 12),
          _SummaryCard(label: 'Payments Received', value: '${summary.paid}', icon: Icons.check_circle_rounded, color: const Color(0xFF0B833D)),
          const SizedBox(width: 12),
          _SummaryCard(label: 'Pending Payments', value: '${summary.unpaid}', icon: Icons.pending_rounded, color: const Color(0xFFDD6B20)),
          const SizedBox(width: 12),
          _SummaryCard(label: 'Total Amount', value: '₹${summary.amount.toStringAsFixed(0)}', icon: Icons.currency_rupee_rounded, color: const Color(0xFF0B833D)),
        ]),
        const SizedBox(height: 20),

        Expanded(child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE9ECEF))),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
              child: Row(children: [
                const Icon(Icons.biotech_rounded, size: 16, color: Color(0xFF0B833D)),
                const SizedBox(width: 8),
                Text('Sample Collections — ${_fmt(patProvider.selectedDate)}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
              ]),
            ),
            _tableHeader(),
            Expanded(child: collections.isEmpty
                ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.biotech_outlined, size: 40, color: Color(0xFFADB5BD)),
              const SizedBox(height: 10),
              Text('No collections for ${_fmt(patProvider.selectedDate)}', style: GoogleFonts.inter(color: const Color(0xFFADB5BD))),
              const SizedBox(height: 4),
              Text('Select another date or collect samples', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD))),
            ]))
                : ListView.separated(
              itemCount: collections.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
              itemBuilder: (ctx, i) => _PatientCollectionRow(collection: collections[i]),
            )),
          ]),
        )),
      ]),
    );
  }

  Widget _tableHeader() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    color: const Color(0xFFF8F9FA),
    child: Row(children: [
      _hCell('PATIENT NAME', 2), _hCell('POLICY NO', 1), _hCell('TESTS', 2),
      _hCell('SAMPLE STATUS', 1), _hCell('AMOUNT', 1), _hCell('PAYMENT', 1),
      _hCell('INVOICE NO', 1), _hCell('ACTION', 1),
    ]),
  );
}

// ── Patient Collection Row ────────────────────────────────────────────────────
class _PatientCollectionRow extends StatelessWidget {
  final SampleCollectionModel collection;
  const _PatientCollectionRow({required this.collection});

  @override
  Widget build(BuildContext context) {
    final patient = allPatients.firstWhere((p) => p.id == collection.patientId, orElse: () => allPatients.first);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(children: [
        Expanded(flex: 2, child: Row(children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFF0B833D).withOpacity(0.10),
            child: Text(patient.name[0], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D))),
          ),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(patient.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
            Text('${patient.age}y · ${patient.gender}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD))),
          ]),
        ])),
        Expanded(flex: 1, child: Text(patient.policyNo, style: _cellStyle)),
        Expanded(flex: 2, child: Text(collection.tests, style: _cellStyle, overflow: TextOverflow.ellipsis)),
        Expanded(flex: 1, child: _sampleBadge(collection.sampleStatus)),
        Expanded(flex: 1, child: Text('₹${collection.amount.toStringAsFixed(0)}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF212529)))),
        Expanded(flex: 1, child: _paymentBadge(collection.paymentReceived)),
        Expanded(flex: 1, child: Text(
          collection.invoiceNo.isEmpty ? '—' : collection.invoiceNo,
          style: GoogleFonts.inter(fontSize: 12, color: collection.invoiceNo.isEmpty ? const Color(0xFFADB5BD) : const Color(0xFF0B833D), fontWeight: FontWeight.w600),
        )),
        Expanded(flex: 1, child: ElevatedButton(
          onPressed: () => context.go('/collections/${collection.id}/payment'),
          style: ElevatedButton.styleFrom(
            backgroundColor: collection.paymentReceived ? const Color(0xFFF8F9FA) : const Color(0xFF0B833D),
            foregroundColor: collection.paymentReceived ? const Color(0xFF495057) : Colors.white,
            elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Text(collection.paymentReceived ? 'View' : 'Enter Payment', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
        )),
      ]),
    );
  }

  TextStyle get _cellStyle => GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057));

  Widget _sampleBadge(String status) {
    final colors = {'Collected': const Color(0xFF1565C0), 'Processing': const Color(0xFFDD6B20), 'Reported': const Color(0xFF0B833D)};
    final c = colors[status] ?? const Color(0xFF495057);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: c)),
    );
  }

  Widget _paymentBadge(bool received) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: received ? const Color(0xFF0B833D).withOpacity(0.08) : const Color(0xFFDD6B20).withOpacity(0.08),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(received ? 'Paid' : 'Unpaid', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
        color: received ? const Color(0xFF0B833D) : const Color(0xFFDD6B20))),
  );
}

// ── Add Patient Form ──────────────────────────────────────────────────────────
class _AddPatientForm extends StatefulWidget {
  const _AddPatientForm();

  @override
  State<_AddPatientForm> createState() => _AddPatientFormState();
}

class _AddPatientFormState extends State<_AddPatientForm> {
  final _nameCtrl   = TextEditingController();
  final _ageCtrl    = TextEditingController();
  final _policyCtrl = TextEditingController();
  final _cardCtrl   = TextEditingController();
  final _phoneCtrl  = TextEditingController();
  final _addrCtrl   = TextEditingController();
  String _gender = 'Male';

  @override
  void dispose() {
    _nameCtrl.dispose(); _ageCtrl.dispose(); _policyCtrl.dispose();
    _cardCtrl.dispose(); _phoneCtrl.dispose(); _addrCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PatientProvider>();
    return Container(
      width: 300,
      decoration: const BoxDecoration(color: Colors.white, border: Border(left: BorderSide(color: Color(0xFFE9ECEF)))),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
          child: Row(children: [
            Text('Add Patient', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
            const Spacer(),
            IconButton(icon: const Icon(Icons.close, size: 18), onPressed: provider.hideAddPatient, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          ]),
        ),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _field('Patient Name *', _nameCtrl, 'Full name'),
            _field('Age', _ageCtrl, 'e.g. 35'),
            // Gender Selector
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Gender', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
                const SizedBox(height: 5),
                StatefulBuilder(
                  builder: (_, setGender) => Row(
                    children: ['Male', 'Female', 'Other'].map((g) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => setGender(() => _gender = g),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: _gender == g ? const Color(0xFF0B833D) : const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: _gender == g ? const Color(0xFF0B833D) : const Color(0xFFE9ECEF)),
                          ),
                          child: Text(g, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: _gender == g ? Colors.white : const Color(0xFF495057))),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ]),
            ),
            _field('Policy Number *', _policyCtrl, 'POL001'),
            _field('Card Number', _cardCtrl, 'CRD001'),
            _field('Phone', _phoneCtrl, '10-digit number'),
            _field('Address', _addrCtrl, 'City, State'),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () {
                if (_nameCtrl.text.isEmpty || _policyCtrl.text.isEmpty) return;
                provider.addPatient(PatientModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  companyId: '',
                  name: _nameCtrl.text,
                  age: int.tryParse(_ageCtrl.text) ?? 0,
                  gender: _gender,
                  policyNo: _policyCtrl.text,
                  cardNo: _cardCtrl.text,
                  phone: _phoneCtrl.text,
                  address: _addrCtrl.text,
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Save Patient', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            )),
          ]),
        )),
      ]),
    );
  }
}

// ── Reusable Summary Card ─────────────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _SummaryCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE9ECEF))),
      child: Row(children: [
        Container(width: 36, height: 36,
          decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(9)),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF212529))),
          Text(label, style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
        ]),
      ]),
    ));
  }
}

// ── Shared Helpers ────────────────────────────────────────────────────────────
Widget _hCell(String t, int flex) => Expanded(
  flex: flex,
  child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0B833D), width: 1.5)),
      ),
    ),
  ]),
);

String _fmt(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';