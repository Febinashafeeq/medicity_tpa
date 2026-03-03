import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../services/insurance_provider.dart';
import '../../../../services/patients_provider.dart';
import '../../../../services/tpa_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../shared/constants/responsive_helper.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../models/models.dart';


// class PatientListScreen extends StatelessWidget {
//   final String tpaId;
//   final String companyId;
//   const PatientListScreen({super.key, required this.tpaId, required this.companyId});
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<TpaProvider>().fetchTpas();
//       context.read<TpaProvider>().fetchCompanies(tpaId: tpaId);
//     });
//     return _PatientListView(tpaId: tpaId, companyId: companyId);
//   }
// }
// class PatientListScreen extends StatelessWidget {
//   final String tpaId;
//   final String companyId;
//
//   const PatientListScreen({
//     super.key,
//     required this.tpaId,
//     required this.companyId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<TpaProvider>().fetchTpas();
//       context.read<TpaProvider>().fetchCompanies(tpaId: tpaId);
//     });
//     return ChangeNotifierProvider(
//       create: (_) => PatientProvider(),
//       child: _PatientListView(tpaId: tpaId, companyId: companyId),
//     );
//   }
// }
// class _PatientListView extends StatelessWidget {
//   final String tpaId;
//   final String companyId;
//   const _PatientListView({required this.tpaId, required this.companyId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: Column(children: [
//         _TopBar(tpaId: tpaId, companyId: companyId),
//         Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Expanded(child: _PatientContent(tpaId: tpaId, companyId: companyId)),
//           Consumer<PatientProvider>(
//             builder: (_, p, __) => p.showAddPatient ?  _AddPatientForm(tpaId: tpaId, companyId: companyId) : const SizedBox.shrink(),
//           ),
//         ])),
//       ]),
//     );
//   }
// }
//
// // ── Top Bar ───────────────────────────────────────────────────────────────────
// // class _TopBar extends StatelessWidget {
// //   final String tpaId;
// //   final String companyId;
// //   const _TopBar({required this.tpaId, required this.companyId});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final tpaProvider = context.watch<TpaProvider>();
// //     final insProvider   = context.read<InsuranceProvider>();
// //     final patProvider   = context.read<PatientProvider>();
// //     final tpa = tpaProvider.tpaById(tpaId);
// //     final company       = tpaProvider.getCompanyById(companyId);
// //
// //     return Container(
// //       height: 60,
// //       padding: const EdgeInsets.symmetric(horizontal: 24),
// //       color: Colors.white,
// //       child: Row(children: [
// //         InkWell(
// //           onTap: () => context.go('/tpa/$tpaId'),
// //           child: Row(children: [
// //             const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
// //             const SizedBox(width: 4),
// //             Text(tpa?.name ?? '', style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
// //           ]),
// //         ),
// //         const SizedBox(width: 8),
// //         const Icon(Icons.chevron_right, size: 16, color: Color(0xFFADB5BD)),
// //         const SizedBox(width: 4),
// //         Expanded(
// //           child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
// //             Text( '${tpa?.name ?? '...'} › ${company?.name ?? '...'}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
// //             Text('Daily Collections', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
// //           ]),
// //         ),
// //         const Spacer(),
// //         Consumer<PatientProvider>(
// //           builder: (_, p, __) => InkWell(
// //             onTap: () async {
// //               final d = await showDatePicker(
// //                 context: context, initialDate: p.selectedDate,
// //                 firstDate: DateTime(2020), lastDate: DateTime.now(),
// //                 builder: (ctx, child) => Theme(data: ThemeData(colorSchemeSeed: const Color(0xFF0B833D)), child: child!),
// //               );
// //               if (d != null) patProvider.setDate(d);
// //             },
// //             child: Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
// //               decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE9ECEF))),
// //               child: Row(children: [
// //                 const Icon(Icons.calendar_today_rounded, size: 15, color: Color(0xFF0B833D)),
// //                 const SizedBox(width: 8),
// //                 Text(_fmt(p.selectedDate), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
// //               ]),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(width: 12),
// //         Consumer<PatientProvider>(
// //           builder: (_, p, __) => ElevatedButton.icon(
// //             onPressed: patProvider.toggleAddPatient,
// //             icon: Icon(p.showAddPatient ? Icons.close : Icons.person_add_rounded, size: 16),
// //             label: Text(p.showAddPatient ? 'Close' : 'Add Patient', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //             ),
// //           ),
// //         ),
// //       ]),
// //     );
// //   }
// // }
// class _TopBar extends StatelessWidget {
//   final String tpaId;
//   final String companyId;
//   const _TopBar({required this.tpaId, required this.companyId});
//
//   @override
//   Widget build(BuildContext context) {
//     final tpaProvider = context.watch<TpaProvider>();
//     final patProvider = context.watch<PatientProvider>();
//     final tpa         = tpaProvider.tpaById(tpaId);
//     final company     = tpaProvider.getCompanyById(companyId);
//
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       color: Colors.white,
//       child: Row(children: [
//         InkWell(
//           onTap: () => context.go('/tpa/$tpaId'),
//           child: Row(children: [
//             const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
//             const SizedBox(width: 4),
//             Text(tpa?.name ?? '...', style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
//           ]),
//         ),
//         const SizedBox(width: 8),
//         const Icon(Icons.chevron_right, size: 16, color: Color(0xFFADB5BD)),
//         const SizedBox(width: 4),
//         Expanded(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(
//               '${tpa?.name ?? '...'} › ${company?.name ?? '...'}',
//               style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500),
//               overflow: TextOverflow.ellipsis,
//             ),
//             Text('Daily Collections', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
//           ]),
//         ),
//         const SizedBox(width: 12),
//         Consumer<PatientProvider>(
//           builder: (_, p, __) => InkWell(
//             onTap: () async {
//               final d = await showDatePicker(
//                 context: context, initialDate: p.selectedDate,
//                 firstDate: DateTime(2020), lastDate: DateTime.now(),
//                 builder: (ctx, child) => Theme(data: ThemeData(colorSchemeSeed: const Color(0xFF0B833D)), child: child!),
//               );
//               if (d != null) patProvider.setDate(d);
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE9ECEF))),
//               child: Row(children: [
//                 const Icon(Icons.calendar_today_rounded, size: 15, color: Color(0xFF0B833D)),
//                 const SizedBox(width: 8),
//                 Text(_fmt(p.selectedDate), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//               ]),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Consumer<PatientProvider>(
//           builder: (_, p, __) => ElevatedButton.icon(
//             onPressed: patProvider.toggleAddPatient,
//             icon: Icon(p.showAddPatient ? Icons.close : Icons.person_add_rounded, size: 16),
//             label: Text(p.showAddPatient ? 'Close' : 'Add Patient', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
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
// // ── Patient Content ───────────────────────────────────────────────────────────
// class _PatientContent extends StatelessWidget {
//   final String tpaId;
//   final String companyId;
//   const _PatientContent({required this.tpaId, required this.companyId});
//
//   @override
//   Widget build(BuildContext context) {
//     final patProvider = context.watch<PatientProvider>();
//     final patients    = patProvider.patientsForCompany(companyId);
//     final summary     = patProvider.summaryForCompany(companyId);
//     final collections = patProvider.collectionsForCompanyOnDate(companyId);
//
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(children: [
//           _SummaryCard(label: 'Total Patients', value: '${patients.length}', icon: Icons.people_rounded, color: const Color(0xFF1565C0)),
//           const SizedBox(width: 12),
//           _SummaryCard(label: "Today's Collections", value: '${summary.total}', icon: Icons.biotech_rounded, color: const Color(0xFF0B833D)),
//           const SizedBox(width: 12),
//           _SummaryCard(label: 'Payments Received', value: '${summary.paid}', icon: Icons.check_circle_rounded, color: const Color(0xFF0B833D)),
//           const SizedBox(width: 12),
//           _SummaryCard(label: 'Pending Payments', value: '${summary.unpaid}', icon: Icons.pending_rounded, color: const Color(0xFFDD6B20)),
//           const SizedBox(width: 12),
//           _SummaryCard(label: 'Total Amount', value: '₹${summary.amount.toStringAsFixed(0)}', icon: Icons.currency_rupee_rounded, color: const Color(0xFF0B833D)),
//         ]),
//         const SizedBox(height: 20),
//
//         Expanded(child: Container(
//           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE9ECEF))),
//           child: Column(children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
//               child: Row(children: [
//                 const Icon(Icons.biotech_rounded, size: 16, color: Color(0xFF0B833D)),
//                 const SizedBox(width: 8),
//                 Text('Sample Collections — ${_fmt(patProvider.selectedDate)}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//               ]),
//             ),
//             _tableHeader(),
//             Expanded(child: collections.isEmpty
//                 ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               const Icon(Icons.biotech_outlined, size: 40, color: Color(0xFFADB5BD)),
//               const SizedBox(height: 10),
//               Text('No collections for ${_fmt(patProvider.selectedDate)}', style: GoogleFonts.inter(color: const Color(0xFFADB5BD))),
//               const SizedBox(height: 4),
//               Text('Select another date or collect samples', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD))),
//             ]))
//                 : ListView.separated(
//               itemCount: collections.length,
//               separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF1F3F5)),
//               itemBuilder: (ctx, i) => _PatientCollectionRow(collection: collections[i]),
//             )),
//           ]),
//         )),
//       ]),
//     );
//   }
//
//   Widget _tableHeader() => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     color: const Color(0xFFF8F9FA),
//     child: Row(children: [
//       _hCell('PATIENT NAME', 2), _hCell('POLICY NO', 1), _hCell('TESTS', 2),
//       _hCell('SAMPLE STATUS', 1), _hCell('AMOUNT', 1), _hCell('PAYMENT', 1),
//       _hCell('INVOICE NO', 1), _hCell('ACTION', 1),
//     ]),
//   );
// }
//
// // ── Patient Collection Row ────────────────────────────────────────────────────
// class _PatientCollectionRow extends StatelessWidget {
//   final SampleCollectionModel collection;
//   const _PatientCollectionRow({required this.collection});
//
//   @override
//   Widget build(BuildContext context) {
//     final patient = allPatients.firstWhere((p) => p.id == collection.patientId, orElse: () => allPatients.first);
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Row(children: [
//         Expanded(flex: 2, child: Row(children: [
//           CircleAvatar(
//             radius: 14,
//             backgroundColor: const Color(0xFF0B833D).withOpacity(0.10),
//             child: Text(patient.name[0], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D))),
//           ),
//           const SizedBox(width: 8),
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(patient.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//             Text('${patient.age}y · ${patient.gender}', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD))),
//           ]),
//         ])),
//         Expanded(flex: 1, child: Text(patient.policyNo, style: _cellStyle)),
//         Expanded(flex: 2, child: Text(collection.tests, style: _cellStyle, overflow: TextOverflow.ellipsis)),
//         Expanded(flex: 1, child: _sampleBadge(collection.sampleStatus)),
//         Expanded(flex: 1, child: Text('₹${collection.amount.toStringAsFixed(0)}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF212529)))),
//         Expanded(flex: 1, child: _paymentBadge(collection.paymentReceived)),
//         Expanded(flex: 1, child: Text(
//           collection.invoiceNo.isEmpty ? '—' : collection.invoiceNo,
//           style: GoogleFonts.inter(fontSize: 12, color: collection.invoiceNo.isEmpty ? const Color(0xFFADB5BD) : const Color(0xFF0B833D), fontWeight: FontWeight.w600),
//         )),
//         Expanded(flex: 1, child: ElevatedButton(
//           onPressed: () => context.go('/collections/${collection.id}/payment'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: collection.paymentReceived ? const Color(0xFFF8F9FA) : const Color(0xFF0B833D),
//             foregroundColor: collection.paymentReceived ? const Color(0xFF495057) : Colors.white,
//             elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//           ),
//           child: Text(collection.paymentReceived ? 'View' : 'Enter Payment', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
//         )),
//       ]),
//     );
//   }
//
//   TextStyle get _cellStyle => GoogleFonts.inter(fontSize: 12, color: const Color(0xFF495057));
//
//   Widget _sampleBadge(String status) {
//     final colors = {'Collected': const Color(0xFF1565C0), 'Processing': const Color(0xFFDD6B20), 'Reported': const Color(0xFF0B833D)};
//     final c = colors[status] ?? const Color(0xFF495057);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
//       child: Text(status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: c)),
//     );
//   }
//
//   Widget _paymentBadge(bool received) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//     decoration: BoxDecoration(
//       color: received ? const Color(0xFF0B833D).withOpacity(0.08) : const Color(0xFFDD6B20).withOpacity(0.08),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Text(received ? 'Paid' : 'Unpaid', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600,
//         color: received ? const Color(0xFF0B833D) : const Color(0xFFDD6B20))),
//   );
// }
//
// // ── Add Patient Form ──────────────────────────────────────────────────────────
// class _AddPatientForm extends StatefulWidget {
//   final String tpaId;
//   final String companyId;
//   const _AddPatientForm({required this.tpaId, required this.companyId});
//
//   @override
//   State<_AddPatientForm> createState() => _AddPatientFormState();
// }
//
// class _AddPatientFormState extends State<_AddPatientForm> {
//   final _nameCtrl   = TextEditingController();
//   final _ageCtrl    = TextEditingController();
//   final _policyCtrl = TextEditingController();
//   final _cardCtrl   = TextEditingController();
//   final _phoneCtrl  = TextEditingController();
//   final _addrCtrl   = TextEditingController();
//   String _gender = 'Male';
//   String _visitType  = 'Home';
//
//   @override
//   void dispose() {
//     _nameCtrl.dispose(); _ageCtrl.dispose(); _policyCtrl.dispose();
//     _cardCtrl.dispose(); _phoneCtrl.dispose(); _addrCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<PatientProvider>();
//     return Container(
//       width: 300,
//       decoration: const BoxDecoration(color: Colors.white, border: Border(left: BorderSide(color: Color(0xFFE9ECEF)))),
//       child: Column(children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//           decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF)))),
//           child: Row(children: [
//             Text('Add Patient', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
//             const Spacer(),
//             IconButton(icon: const Icon(Icons.close, size: 18), onPressed: provider.hideAddPatient, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
//           ]),
//         ),
//         Expanded(child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             _field('Patient Name *', _nameCtrl, 'Full name'),
//             _field('Age', _ageCtrl, 'e.g. 35'),
//             // Gender Selector
//             Padding(
//               padding: const EdgeInsets.only(bottom: 14),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Text('Gender', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//                 const SizedBox(height: 5),
//                 StatefulBuilder(
//                   builder: (_, setGender) => Row(
//                     children: ['Male', 'Female', 'Other'].map((g) => Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: InkWell(
//                         onTap: () => setGender(() => _gender = g),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//                           decoration: BoxDecoration(
//                             color: _gender == g ? const Color(0xFF0B833D) : const Color(0xFFF8F9FA),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(color: _gender == g ? const Color(0xFF0B833D) : const Color(0xFFE9ECEF)),
//                           ),
//                           child: Text(g, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: _gender == g ? Colors.white : const Color(0xFF495057))),
//                         ),
//                       ),
//                     )).toList(),
//                   ),
//                 ),
//               ]),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Visit Type',
//                     style: GoogleFonts.inter(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xFF212529),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   StatefulBuilder(
//                     builder: (_, setVisitType) => Row(
//                       children: ['Home', 'Centre'].map((type) => Padding(
//                         padding: const EdgeInsets.only(right: 8),
//                         child: InkWell(
//                           onTap: () => setVisitType(() => _visitType = type),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//                             decoration: BoxDecoration(
//                               color: _visitType == type
//                                   ? const Color(0xFF0B833D)
//                                   : const Color(0xFFF8F9FA),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: _visitType == type
//                                     ? const Color(0xFF0B833D)
//                                     : const Color(0xFFE9ECEF),
//                               ),
//                             ),
//                             child: Text(
//                               type,
//                               style: GoogleFonts.inter(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: _visitType == type
//                                     ? Colors.white
//                                     : const Color(0xFF495057),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             _field('Policy Number *', _policyCtrl, 'POL001'),
//             _field('Card Number', _cardCtrl, 'CRD001'),
//             _field('Phone', _phoneCtrl, '10-digit number'),
//             _field('Address', _addrCtrl, 'City, State'),
//             const SizedBox(height: 8),
//             SizedBox(width: double.infinity, child: ElevatedButton(
//               onPressed: () {
//                 if (_nameCtrl.text.isEmpty || _policyCtrl.text.isEmpty) return;
//                 final tpaProvider = context.read<TpaProvider>();
//                 final tpa     = tpaProvider.tpaById(widget.tpaId);
//                 final company = tpaProvider.getCompanyById(widget.companyId);
//
//                 provider.addPatient(
//                   companyId:   widget.companyId,
//                   companyName: company?.name ?? '',
//                   tpaId:       widget.tpaId,
//                   tpaName:     tpa?.name ?? '',
//                   name:        _nameCtrl.text,
//                   age:         int.tryParse(_ageCtrl.text) ?? 0,
//                   gender:      _gender,
//                   policyNo:    _policyCtrl.text,
//                   cardNo:      _cardCtrl.text,
//                   phone:       _phoneCtrl.text,
//                   address:     _addrCtrl.text,
//                   visitType:   _visitType
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF0B833D), foregroundColor: Colors.white, elevation: 0,
//                 padding: const EdgeInsets.symmetric(vertical: 13),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: Text('Save Patient', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
//             )),
//           ]),
//         )),
//       ]),
//     );
//   }
// }
//
// // ── Reusable Summary Card ─────────────────────────────────────────────────────
// class _SummaryCard extends StatelessWidget {
//   final String label;
//   final String value;
//   final IconData icon;
//   final Color color;
//   const _SummaryCard({required this.label, required this.value, required this.icon, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(child: Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE9ECEF))),
//       child: Row(children: [
//         Container(width: 36, height: 36,
//           decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(9)),
//           child: Icon(icon, size: 18, color: color),
//         ),
//         const SizedBox(width: 10),
//         Expanded( // ← add Expanded here to prevent overflow
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF212529))),
//             Text(label, style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500),
//                 overflow: TextOverflow.ellipsis), // ← ellipsis for long labels
//           ]),
//         ),
//       ]),
//     ));
//   }
// }
//
// // ── Shared Helpers ────────────────────────────────────────────────────────────
// Widget _hCell(String t, int flex) => Expanded(
//   flex: flex,
//   child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFADB5BD), letterSpacing: 0.8)),
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
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
//         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
//         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0B833D), width: 1.5)),
//       ),
//     ),
//   ]),
// );
//
// String _fmt(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

/// changed for responsive
// lib/src/features/mainShell/ui/patients/patient_list_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
//  RESPONSIVE PATIENT LIST / COLLECTIONS SCREEN
//  • Desktop  (≥1024px): 5-col summary row | 8-col table  | side-panel form
//  • Tablet   (600–1023): 3-col summary row | 5-col table  | bottom sheet form
//  • Mobile   (<600px):  2-col summary grid | collection cards | bottom sheet form
// ─────────────────────────────────────────────────────────────────────────────


// ════════════════════════════════════════════════════════════
//  ROOT
// ════════════════════════════════════════════════════════════
class PatientListScreen extends StatelessWidget {
  final String tpaId;
  final String companyId;
  const PatientListScreen({super.key, required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TpaProvider>().fetchTpas();
      context.read<TpaProvider>().fetchCompanies(tpaId: tpaId);
    });
    return ChangeNotifierProvider(

      create: (_) => PatientProvider()..fetchPatients(companyId: companyId),
      child: _PatientListView(tpaId: tpaId, companyId: companyId),
    );
  }
}

class _PatientListView extends StatelessWidget {
  final String tpaId;
  final String companyId;
  const _PatientListView({required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(children: [
        _TopBar(tpaId: tpaId, companyId: companyId),
        Expanded(
          child: isDesktop
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _PatientContent(tpaId: tpaId, companyId: companyId)),
            Consumer<PatientProvider>(
              builder: (_, p, __) => p.showAddPatient
                  ? _AddPatientPanel(tpaId: tpaId, companyId: companyId)
                  : const SizedBox.shrink(),
            ),
          ])
              : _PatientContent(tpaId: tpaId, companyId: companyId),
        ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  TOP BAR
// ════════════════════════════════════════════════════════════
class _TopBar extends StatelessWidget {
  final String tpaId;
  final String companyId;
  const _TopBar({required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final tpa      = context.watch<TpaProvider>().tpaById(tpaId);
    final company  = context.watch<TpaProvider>().getCompanyById(companyId);
    final isMobile = ResponsiveHelper.isMobile(context);
    final padding  = ResponsiveHelper.pagePadding(context);

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: isMobile ? 10 : 0),
      constraints: BoxConstraints(minHeight: isMobile ? 68 : 60),
      child: isMobile
          ? _MobileTopBar(tpa: tpa, company: company, tpaId: tpaId, companyId: companyId)
          : _DesktopTabletTopBar(tpa: tpa, company: company, tpaId: tpaId, companyId: companyId),
    );
  }
}

class _DesktopTabletTopBar extends StatelessWidget {
  final TpaModel? tpa;
  final InsuranceCompanyModel? company;
  final String tpaId, companyId;
  const _DesktopTabletTopBar({required this.tpa, required this.company, required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final patProvider = context.watch<PatientProvider>();
    return Row(children: [
      // Back nav
      GestureDetector(
        onTap: () => context.go('/tpa/$tpaId'),
        child: Row(children: [
          const Icon(Icons.arrow_back_ios_rounded, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(tpa?.name ?? '...', style: GoogleFonts.inter(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w500)),
        ]),
      ),
      const SizedBox(width: 8),
      const Icon(Icons.chevron_right, size: 16, color: AppColors.textLight),
      const SizedBox(width: 4),
      Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${tpa?.name ?? '...'} › ${company?.name ?? '...'}',
              style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis),
          Text('Daily Collections',
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark)),
        ]),
      ),
      const SizedBox(width: 12),
      // Date picker
      _DatePickerButton(patProvider: patProvider),
      const SizedBox(width: 12),
      // Add Patient
      Consumer<PatientProvider>(
        builder: (_, p, __) => _AddPatientButton(
          isOpen: p.showAddPatient,
          label: p.showAddPatient ? 'Close' : 'Add Patient',
          onTap: () => _handleAddTap(context, p),
        ),
      ),
    ]);
  }

  void _handleAddTap(BuildContext context, PatientProvider provider) {
    if (ResponsiveHelper.isDesktop(context)) {
      provider.toggleAddPatient();
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ChangeNotifierProvider.value(
          value: provider,
          child: _AddPatientSheet(tpaId: tpaId, companyId: companyId),
        ),
      );
    }
  }
}

class _MobileTopBar extends StatelessWidget {
  final TpaModel? tpa;
  final InsuranceCompanyModel? company;
  final String tpaId, companyId;
  const _MobileTopBar({required this.tpa, required this.company, required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final patProvider = context.watch<PatientProvider>();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Row 1: back + add button
      Row(children: [
        GestureDetector(
          onTap: () => context.go('/tpa/$tpaId'),
          child: Row(children: [
            const Icon(Icons.arrow_back_ios_rounded, size: 13, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(tpa?.name ?? '...', style: GoogleFonts.inter(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
          ]),
        ),
        const Spacer(),
        _DatePickerButton(patProvider: patProvider, compact: true),
        const SizedBox(width: 8),
        Consumer<PatientProvider>(
          builder: (_, p, __) => _AddPatientButton(
            isOpen: p.showAddPatient,
            label: 'Add',
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => ChangeNotifierProvider.value(
                value: p,
                child: _AddPatientSheet(tpaId: tpaId, companyId: companyId),
              ),
            ),
          ),
        ),
      ]),
      const SizedBox(height: 4),
      // Row 2: title
      Text('Daily Collections',
          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textDark)),
      Text('${tpa?.name ?? '...'} › ${company?.name ?? '...'}',
          style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight),
          maxLines: 1, overflow: TextOverflow.ellipsis),
    ]);
  }
}

// ── Date Picker Button ─────────────────────────────────────────────────────
class _DatePickerButton extends StatelessWidget {
  final PatientProvider patProvider;
  final bool compact;
  const _DatePickerButton({required this.patProvider, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () async {
        final d = await showDatePicker(
          context: context,
          initialDate: patProvider.selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          builder: (ctx, child) => Theme(
            data: ThemeData(colorSchemeSeed: AppColors.primary),
            child: child!,
          ),
        );
        if (d != null) patProvider.setDate(d);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(children: [
          const Icon(Icons.calendar_today_rounded, size: 15, color: AppColors.primary),
          if (!compact) ...[
            const SizedBox(width: 8),
            Text(_fmt(patProvider.selectedDate),
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ],
        ]),
      ),
    );
  }
}

class _AddPatientButton extends StatelessWidget {
  final bool isOpen;
  final String label;
  final VoidCallback onTap;
  const _AddPatientButton({required this.isOpen, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(isOpen ? Icons.close : Icons.person_add_rounded, size: 15),
      label: Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  PATIENT CONTENT  — patients only, zero collection logic
// ════════════════════════════════════════════════════════════
class _PatientContent extends StatelessWidget {
  final String tpaId, companyId;
  const _PatientContent({required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final patProvider = context.watch<PatientProvider>();
    final patients    = patProvider.patientsForCompany(companyId);
    final padding     = ResponsiveHelper.pagePadding(context);
    final isMobile    = ResponsiveHelper.isMobile(context);

    if (patProvider.loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(children: [

          // ── Card header ──────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border))),
            child: Row(children: [
              const Icon(Icons.people_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('Enrolled Patients',
                  style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const Spacer(),
              if (patients.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('${patients.length} patients',
                      style: GoogleFonts.inter(
                          fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ),
            ]),
          ),

          // ── Table header (desktop/tablet only) ───────────
          if (!isMobile)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.surface,
              child: Row(children: [
                _hCell('NAME', 3),
                _hCell('POLICY NO', 2),
                _hCell('AGE / GENDER', 1),
                _hCell('PHONE', 2),
                _hCell('VISIT', 1),
                _hCell('', 1), // actions
              ]),
            ),

          // ── List ─────────────────────────────────────────
          Expanded(
            child: patients.isEmpty
                ? Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.people_outline_rounded,
                    size: 48, color: AppColors.textLight),
                const SizedBox(height: 12),
                Text('No patients enrolled yet',
                    style: GoogleFonts.inter(
                        fontSize: 15, fontWeight: FontWeight.w600,
                        color: AppColors.textLight)),
                const SizedBox(height: 4),
                Text('Tap "Add Patient" to get started',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.textLight)),
              ]),
            )
                : ListView.separated(
              itemCount: patients.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1, color: Color(0xFFF1F3F5)),
              itemBuilder: (ctx, i) => isMobile
                  ? _PatientMobileRow(
                patient: patients[i],
                tpaId: tpaId,
                companyId: companyId,
              )
                  : _PatientDesktopRow(
                patient: patients[i],
                tpaId: tpaId,
                companyId: companyId,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// ── Desktop Row ───────────────────────────────────────────────
class _PatientDesktopRow extends StatelessWidget {
  final PatientModel patient;
  final String tpaId, companyId;
  const _PatientDesktopRow(
      {required this.patient, required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        // Name + avatar
        Expanded(flex: 3, child: Row(children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.primary.withOpacity(0.10),
            child: Text(patient.name[0],
                style: GoogleFonts.inter(
                    fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(patient.name,
              style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
              overflow: TextOverflow.ellipsis)),
        ])),
        // Policy
        Expanded(flex: 2, child: Text(patient.policyNo,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMid),
            overflow: TextOverflow.ellipsis)),
        // Age / gender
        Expanded(flex: 1, child: Text('${patient.age}y · ${patient.gender}',
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMid))),
        // Phone
        Expanded(flex: 2, child: Text(
            patient.phone.isEmpty ? '—' : patient.phone,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMid))),
        // Visit badge
        Expanded(flex: 1, child: _visitBadge(patient.visitType)),
        // History button
        Expanded(flex: 1, child: TextButton.icon(
          onPressed: () => context.go(
              '/tpa/$tpaId/companies/$companyId/patients/${patient.id}/history'),
          icon: const Icon(Icons.history_rounded, size: 13),
          label: Text('History',
              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,
          ),
        )),
      ]),
    );
  }
}

// ── Mobile Row ────────────────────────────────────────────────
class _PatientMobileRow extends StatelessWidget {
  final PatientModel patient;
  final String tpaId, companyId;
  const _PatientMobileRow(
      {required this.patient, required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.primary.withOpacity(0.10),
          child: Text(patient.name[0],
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(patient.name,
              style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
              overflow: TextOverflow.ellipsis),
          Text('${patient.age}y · ${patient.gender} · ${patient.policyNo}',
              style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight),
              overflow: TextOverflow.ellipsis),
        ])),
        const SizedBox(width: 8),
        _visitBadge(patient.visitType),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => context.go(
              '/tpa/$tpaId/companies/$companyId/patients/${patient.id}/history'),
          icon: const Icon(Icons.history_rounded, size: 18, color: AppColors.primary),
          tooltip: 'History',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ]),
    );
  }
}

// ── Visit badge ───────────────────────────────────────────────
Widget _visitBadge(String type) {
  final isHome = type == 'Home';
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: isHome
          ? const Color(0xFF1565C0).withOpacity(0.08)
          : AppColors.primary.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(type,
        style: GoogleFonts.inter(
            fontSize: 10, fontWeight: FontWeight.w600,
            color: isHome ? const Color(0xFF1565C0) : AppColors.primary)),
  );
}

Widget _hCell(String t, int flex) => Expanded(
  flex: flex,
  child: Text(t, style: GoogleFonts.inter(
      fontSize: 10, fontWeight: FontWeight.w700,
      color: AppColors.textLight, letterSpacing: 0.8)),
);

String _fmt(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';


class _CardData {
  final String label, value;
  final IconData icon;
  final Color color;
  const _CardData(this.label, this.value, this.icon, this.color);
}



// ════════════════════════════════════════════════════════════
//  DESKTOP SIDE PANEL
// ════════════════════════════════════════════════════════════
class _AddPatientPanel extends StatelessWidget {
  final String tpaId, companyId;
  const _AddPatientPanel({required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(left: BorderSide(color: AppColors.border)),
      ),
      child: _AddPatientFormBody(
        tpaId: tpaId,
        companyId: companyId,
        onClose: () => context.read<PatientProvider>().hideAddPatient(),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  BOTTOM SHEET
// ════════════════════════════════════════════════════════════
class _AddPatientSheet extends StatelessWidget {
  final String tpaId, companyId;
  const _AddPatientSheet({required this.tpaId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.90,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (ctx, scrollCtrl) => SafeArea(
        bottom: true,
        child: Container(
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
                    color: AppColors.border, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Expanded(
              child: _AddPatientFormBody(
                tpaId: tpaId,
                companyId: companyId,
                scrollController: scrollCtrl,
                onClose: () => Navigator.of(context).pop(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  SHARED ADD FORM BODY
// ════════════════════════════════════════════════════════════
class _AddPatientFormBody extends StatefulWidget {
  final String tpaId, companyId;
  final VoidCallback onClose;
  final ScrollController? scrollController;
  const _AddPatientFormBody({
    required this.tpaId, required this.companyId,
    required this.onClose, this.scrollController,
  });

  @override
  State<_AddPatientFormBody> createState() => _AddPatientFormBodyState();
}

class _AddPatientFormBodyState extends State<_AddPatientFormBody> {
  final _nameCtrl   = TextEditingController();
  final _ageCtrl    = TextEditingController();
  final _policyCtrl = TextEditingController();
  final _cardCtrl   = TextEditingController();
  final _phoneCtrl  = TextEditingController();
  final _addrCtrl   = TextEditingController();
  String _gender    = 'Male';
  String _visitType = 'Home';

  @override
  void dispose() {
    _nameCtrl.dispose(); _ageCtrl.dispose(); _policyCtrl.dispose();
    _cardCtrl.dispose(); _phoneCtrl.dispose(); _addrCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PatientProvider>();

    return Column(children: [
      // Header
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
        child: Row(children: [
          Text('Add Patient',
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, size: 18), onPressed: widget.onClose,
            padding: EdgeInsets.zero, constraints: const BoxConstraints(),
          ),
        ]),
      ),

      Expanded(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _field('Patient Name *', _nameCtrl, 'Full name'),
            _field('Age',            _ageCtrl,  'e.g. 35'),

            // Gender selector
            _ToggleSelector(
              label: 'Gender',
              options: const ['Male', 'Female', 'Other'],
              selected: _gender,
              onChanged: (v) => setState(() => _gender = v),
            ),

            // Visit type selector
            _ToggleSelector(
              label: 'Visit Type',
              options: const ['Home', 'Centre'],
              selected: _visitType,
              onChanged: (v) => setState(() => _visitType = v),
            ),

            _field('Policy Number *', _policyCtrl, 'POL001'),
            _field('Card Number',     _cardCtrl,   'CRD001'),
            _field('Phone',           _phoneCtrl,  '10-digit number'),
            _field('Address',         _addrCtrl,   'City, State'),
            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameCtrl.text.isEmpty || _policyCtrl.text.isEmpty) return;
                  final tpaProvider = context.read<TpaProvider>();
                  final tpa     = tpaProvider.tpaById(widget.tpaId);
                  final company = tpaProvider.getCompanyById(widget.companyId);
                  provider.addPatient(
                    companyId:   widget.companyId,
                    companyName: company?.name ?? '',
                    tpaId:       widget.tpaId,
                    tpaName:     tpa?.name ?? '',
                    name:        _nameCtrl.text,
                    age:         int.tryParse(_ageCtrl.text) ?? 0,
                    gender:      _gender,
                    policyNo:    _policyCtrl.text,
                    cardNo:      _cardCtrl.text,
                    phone:       _phoneCtrl.text,
                    address:     _addrCtrl.text,
                    visitType:   _visitType,
                  );
                  widget.onClose();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Save Patient', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
          ]),
        ),
      ),
    ]);
  }
}

// ── Toggle Selector  (Gender / Visit Type) ────────────────────
class _ToggleSelector extends StatelessWidget {
  final String label;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  const _ToggleSelector({required this.label, required this.options, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          children: options.map((o) => GestureDetector(
            onTap: () => onChanged(o),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: selected == o ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: selected == o ? AppColors.primary : AppColors.border),
              ),
              child: Text(o,
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: selected == o ? Colors.white : AppColors.textMid)),
            ),
          )).toList(),
        ),
      ]),
    );
  }
}




Widget _field(String label, TextEditingController ctrl, String hint) => Padding(
  padding: const EdgeInsets.only(bottom: 14),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
    const SizedBox(height: 5),
    TextField(
      controller: ctrl,
      style: GoogleFonts.inter(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textLight),
        filled: true, fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border:        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      ),
    ),
  ]),
);
