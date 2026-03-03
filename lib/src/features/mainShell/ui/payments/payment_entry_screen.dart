import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/collection_provider.dart';
import '../../../../services/payment_provider.dart';
import '../../../../shared/constants/responsive_helper.dart';
import '../../../../shared/theme/app_colors.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../patients/patient_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';


// class PaymentEntryScreen extends StatelessWidget {
//   final String collectionId;
//   const PaymentEntryScreen({super.key, required this.collectionId});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) {
//         final provider = PaymentProvider();
//         final collection = allCollections.firstWhere((c) => c.id == collectionId, orElse: () => allCollections.first);
//         provider.initFromCollection(collection);
//         return provider;
//       },
//       child: _PaymentEntryView(collectionId: collectionId),
//     );
//   }
// }
//
// class _PaymentEntryView extends StatelessWidget {
//   final String collectionId;
//   const _PaymentEntryView({required this.collectionId});
//
//   SampleCollectionModel get _collection =>
//       allCollections.firstWhere((c) => c.id == collectionId, orElse: () => allCollections.first);
//
//   PatientModel get _patient =>
//       allPatients.firstWhere((p) => p.id == _collection.patientId, orElse: () => allPatients.first);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: Column(children: [
//         const _TopBar(),
//         Expanded(child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Expanded(flex: 4, child: Column(children: [
//               _PatientCard(patient: _patient),
//               const SizedBox(height: 16),
//               _SampleCard(collection: _collection),
//             ])),
//             const SizedBox(width: 20),
//             Expanded(flex: 5, child: _PaymentCard(collection: _collection, collectionId: collectionId)),
//           ]),
//         )),
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
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       color: Colors.white,
//       child: Row(children: [
//         InkWell(
//           onTap: () => context.go('/collections'),
//           child: Row(children: [
//             const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
//             const SizedBox(width: 4),
//             Text('Collections', style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
//           ]),
//         ),
//         const SizedBox(width: 8),
//         const Icon(Icons.chevron_right, size: 16, color: Color(0xFFADB5BD)),
//         const SizedBox(width: 4),
//         Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text('Daily Collections › Edit', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
//           Text('Payment Entry', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
//         ]),
//       ]),
//     );
//   }
// }
//
// // ── Patient Card ──────────────────────────────────────────────────────────────
// class _PatientCard extends StatelessWidget {
//   final PatientModel patient;
//   const _PatientCard({required this.patient});
//
//   @override
//   Widget build(BuildContext context) {
//     return _InfoCard(
//       title: 'Patient Information',
//       icon: Icons.person_rounded,
//       child: Column(children: [
//         Row(children: [
//           CircleAvatar(
//             radius: 22,
//             backgroundColor: const Color(0xFF0B833D).withOpacity(0.10),
//             child: Text(patient.name[0], style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D))),
//           ),
//           const SizedBox(width: 14),
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(patient.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
//             Text('${patient.age} yrs · ${patient.gender}', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD))),
//           ]),
//         ]),
//         const SizedBox(height: 14),
//         const Divider(color: Color(0xFFF1F3F5), height: 1),
//         const SizedBox(height: 14),
//         _infoRow('Policy Number', patient.policyNo),
//         _infoRow('Card Number', patient.cardNo),
//         _infoRow('Phone', patient.phone),
//         _infoRow('Address', patient.address),
//       ]),
//     );
//   }
// }
//
// // ── Sample Card ───────────────────────────────────────────────────────────────
// class _SampleCard extends StatelessWidget {
//   final SampleCollectionModel collection;
//   const _SampleCard({required this.collection});
//
//   @override
//   Widget build(BuildContext context) {
//     return _InfoCard(
//       title: 'Sample Details',
//       icon: Icons.biotech_rounded,
//       child: Column(children: [
//         _infoRow('Collection ID', collection.id.toUpperCase()),
//         _infoRow('Date', _fmt(collection.date)),
//         _infoRow('Tests Ordered', collection.tests),
//         _infoRow('Sample Status', collection.sampleStatus),
//         _infoRow('Billed Amount', '₹${collection.amount.toStringAsFixed(0)}'),
//       ]),
//     );
//   }
// }
//
// // ── Payment Card ──────────────────────────────────────────────────────────────
// class _PaymentCard extends StatefulWidget {
//   final SampleCollectionModel collection;
//   final String collectionId;
//   const _PaymentCard({required this.collection, required this.collectionId});
//
//   @override
//   State<_PaymentCard> createState() => _PaymentCardState();
// }
//
// class _PaymentCardState extends State<_PaymentCard> {
//   final _invoiceCtrl  = TextEditingController();
//   final _amountCtrl   = TextEditingController();
//   final _remarksCtrl  = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _invoiceCtrl.text = widget.collection.invoiceNo;
//     _amountCtrl.text  = widget.collection.amount.toStringAsFixed(0);
//   }
//
//   @override
//   void dispose() {
//     _invoiceCtrl.dispose();
//     _amountCtrl.dispose();
//     _remarksCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<PaymentProvider>();
//     return _InfoCard(
//       title: 'Payment Entry',
//       icon: Icons.receipt_long_rounded,
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         // Payment toggle
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: provider.paymentReceived ? const Color(0xFF0B833D).withOpacity(0.05) : const Color(0xFFF8F9FA),
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: provider.paymentReceived ? const Color(0xFF0B833D).withOpacity(0.20) : const Color(0xFFE9ECEF)),
//           ),
//           child: Row(children: [
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text('Payment Received?', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
//               Text(provider.paymentReceived ? 'Mark payment details below' : 'Toggle to enter payment', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD))),
//             ]),
//             const Spacer(),
//             Switch(
//               value: provider.paymentReceived,
//               onChanged: context.read<PaymentProvider>().togglePaymentReceived,
//               activeColor: const Color(0xFF0B833D),
//             ),
//           ]),
//         ),
//         const SizedBox(height: 20),
//
//         if (provider.paymentReceived) ...[
//           _label('Invoice Number *'),
//           const SizedBox(height: 6),
//           TextField(controller: _invoiceCtrl, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600), decoration: _inputDecor('e.g. INV-2025-001', prefixIcon: Icons.receipt_outlined)),
//           const SizedBox(height: 16),
//
//           _label('Amount Received (₹) *'),
//           const SizedBox(height: 6),
//           TextField(controller: _amountCtrl, keyboardType: TextInputType.number, style: GoogleFonts.inter(fontSize: 14), decoration: _inputDecor('Enter amount', prefixIcon: Icons.currency_rupee_rounded)),
//           const SizedBox(height: 16),
//
//           _label('Payment Mode'),
//           const SizedBox(height: 6),
//           Wrap(
//             spacing: 8, runSpacing: 8,
//             children: provider.paymentModes.map((m) =>
//                 InkWell(
//                   onTap: () => context.read<PaymentProvider>().setPaymentMode(m),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: provider.paymentMode == m ? const Color(0xFF0B833D) : const Color(0xFFF8F9FA),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: provider.paymentMode == m ? const Color(0xFF0B833D) : const Color(0xFFE9ECEF)),
//                     ),
//                     child: Text(m, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600,
//                         color: provider.paymentMode == m ? Colors.white : const Color(0xFF495057))),
//                   ),
//                 ),
//             ).toList(),
//           ),
//           const SizedBox(height: 16),
//
//           _label('Payment Date'),
//           const SizedBox(height: 6),
//           InkWell(
//             onTap: () async {
//               final payProvider = context.read<PaymentProvider>();
//               final d = await showDatePicker(
//                 context: context, initialDate: payProvider.paymentDate,
//                 firstDate: DateTime(2020), lastDate: DateTime.now(),
//                 builder: (ctx, child) => Theme(data: ThemeData(colorSchemeSeed: const Color(0xFF0B833D)), child: child!),
//               );
//               if (d != null) payProvider.setPaymentDate(d);
//             },
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
//               decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE9ECEF))),
//               child: Row(children: [
//                 const Icon(Icons.calendar_today_rounded, size: 16, color: Color(0xFF0B833D)),
//                 const SizedBox(width: 10),
//                 Text(_fmt(provider.paymentDate), style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF212529))),
//               ]),
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           _label('Remarks (optional)'),
//           const SizedBox(height: 6),
//           TextField(controller: _remarksCtrl, maxLines: 2, style: GoogleFonts.inter(fontSize: 13), decoration: _inputDecor('Any notes about this payment...', prefixIcon: null)),
//           const SizedBox(height: 24),
//         ] else ...[
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(color: const Color(0xFFFFF8E1), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFDD6B20).withOpacity(0.25))),
//             child: Row(children: [
//               const Icon(Icons.info_outline_rounded, color: Color(0xFFDD6B20), size: 16),
//               const SizedBox(width: 8),
//               Text('Payment not yet received. Toggle above to enter payment details.', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFDD6B20))),
//             ]),
//           ),
//           const SizedBox(height: 24),
//         ],
//
//         // Save Button
//         SizedBox(width: double.infinity, child: ElevatedButton(
//           onPressed: provider.saved ? null : () {
//             context.read<PaymentProvider>().savePayment(
//               collectionId: widget.collectionId,
//               invoiceNo: _invoiceCtrl.text,
//               amount: double.tryParse(_amountCtrl.text) ?? widget.collection.amount,
//               remarks: _remarksCtrl.text,
//             );
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Row(children: [
//                 const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
//                 const SizedBox(width: 8),
//                 Text(provider.paymentReceived ? 'Payment saved — Invoice ${_invoiceCtrl.text}' : 'Record updated successfully',
//                     style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
//               ]),
//               backgroundColor: const Color(0xFF0B833D),
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               margin: const EdgeInsets.all(16),
//               duration: const Duration(seconds: 2),
//             ));
//             Future.delayed(const Duration(seconds: 2), () {
//               if (context.mounted) context.go('/collections');
//             });
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF0B833D),
//             disabledBackgroundColor: const Color(0xFF0B833D).withOpacity(0.5),
//             foregroundColor: Colors.white, elevation: 0,
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//           child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Icon(provider.paymentReceived ? Icons.save_rounded : Icons.update_rounded, size: 18),
//             const SizedBox(width: 8),
//             Text(provider.paymentReceived ? 'Save Payment' : 'Update Record', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700)),
//           ]),
//         )),
//       ]),
//     );
//   }
// }
//
// // ── Info Card Wrapper ─────────────────────────────────────────────────────────
// class _InfoCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Widget child;
//   const _InfoCard({required this.title, required this.icon, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       margin: const EdgeInsets.only(bottom: 4),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE9ECEF))),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(children: [
//           Icon(icon, size: 16, color: const Color(0xFF0B833D)),
//           const SizedBox(width: 8),
//           Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
//         ]),
//         const SizedBox(height: 16),
//         const Divider(color: Color(0xFFF1F3F5), height: 1),
//         const SizedBox(height: 16),
//         child,
//       ]),
//     );
//   }
// }
//
// // ── Shared Helpers ────────────────────────────────────────────────────────────
// Widget _infoRow(String label, String value) => Padding(
//   padding: const EdgeInsets.only(bottom: 10),
//   child: Row(children: [
//     SizedBox(width: 130, child: Text(label, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500))),
//     Expanded(child: Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529)))),
//   ]),
// );
//
// Widget _label(String text) => Text(text, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529)));
//
// InputDecoration _inputDecor(String hint, {IconData? prefixIcon}) => InputDecoration(
//   hintText: hint,
//   hintStyle: GoogleFonts.inter(fontSize: 13, color: const Color(0xFFADB5BD)),
//   prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 17, color: const Color(0xFFADB5BD)) : null,
//   filled: true, fillColor: const Color(0xFFF8F9FA),
//   contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
//   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
//   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF0B833D), width: 1.5)),
// );
//
// String _fmt(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

/// changed for reponsive
class PaymentEntryScreen extends StatelessWidget {
  final String collectionId;
  const PaymentEntryScreen({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider   = PaymentProvider();
        final collection = allCollections.firstWhere(
              (c) => c.id == collectionId,
          orElse: () => allCollections.first,
        );
        provider.initFromCollection(collection);
        return provider;
      },
      child: _PaymentEntryView(collectionId: collectionId),
    );
  }
}

class _PaymentEntryView extends StatelessWidget {
  final String collectionId;
  const _PaymentEntryView({required this.collectionId});

  SampleCollectionModel get _collection =>
      allCollections.firstWhere((c) => c.id == collectionId,
          orElse: () => allCollections.first);

  PatientModel get _patient =>
      allPatients.firstWhere((p) => p.id == _collection.patientId,
          orElse: () => allPatients.first);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final padding  = ResponsiveHelper.pagePadding(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(children: [
        _TopBar(collectionId: collectionId),
        Expanded(child: SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: isMobile
          // ── Mobile: stacked column ──────────────────────
              ? Column(children: [
            _PatientCard(patient: _patient),
            const SizedBox(height: 16),
            _SampleCard(collection: _collection),
            const SizedBox(height: 16),
            _PaymentCard(collection: _collection, collectionId: collectionId),
          ])
          // ── Tablet / Desktop: side by side ───────────────
              : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 4, child: Column(children: [
              _PatientCard(patient: _patient),
              const SizedBox(height: 16),
              _SampleCard(collection: _collection),
            ])),
            const SizedBox(width: 20),
            Expanded(flex: 5, child: _PaymentCard(
              collection: _collection,
              collectionId: collectionId,
            )),
          ]),
        )),
      ]),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final String collectionId;
  const _TopBar({required this.collectionId});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
      color: Colors.white,
      child: Row(children: [
        InkWell(
          onTap: () => context.go('/collections'),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(children: [
              const Icon(Icons.arrow_back_ios_rounded, size: 14, color: Color(0xFF0B833D)),
              const SizedBox(width: 4),
              Text('Collections', style: GoogleFonts.inter(
                  fontSize: 13, color: const Color(0xFF0B833D), fontWeight: FontWeight.w500)),
            ]),
          ),
        ),
        if (!isMobile) ...[
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, size: 16, color: Color(0xFFADB5BD)),
          const SizedBox(width: 4),
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Daily Collections › Edit',
                style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
            Text('Payment Entry',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
          ]),
        ] else
          Text('Payment Entry',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
      ]),
    );
  }
}

// ── Patient Card ──────────────────────────────────────────────────────────────
class _PatientCard extends StatelessWidget {
  final PatientModel patient;
  const _PatientCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Patient Information',
      icon: Icons.person_rounded,
      child: Column(children: [
        Row(children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF0B833D).withOpacity(0.10),
            child: Text(patient.name[0],
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0B833D))),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(patient.name,
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF212529)),
                overflow: TextOverflow.ellipsis),
            Text('${patient.age} yrs · ${patient.gender}',
                style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD))),
          ])),
        ]),
        const SizedBox(height: 14),
        const Divider(color: Color(0xFFF1F3F5), height: 1),
        const SizedBox(height: 14),
        _infoRow('Policy Number', patient.policyNo),
        _infoRow('Card Number',   patient.cardNo),
        _infoRow('Phone',         patient.phone),
        _infoRow('Address',       patient.address),
      ]),
    );
  }
}

// ── Sample Card ───────────────────────────────────────────────────────────────
class _SampleCard extends StatelessWidget {
  final SampleCollectionModel collection;
  const _SampleCard({required this.collection});

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Sample Details',
      icon: Icons.biotech_rounded,
      child: Column(children: [
        _infoRow('Collection ID',  collection.id.toUpperCase()),
        _infoRow('Date',           _fmt(collection.date)),
        _infoRow('Tests Ordered',  collection.tests),
        _infoRow('Sample Status',  collection.sampleStatus),
        _infoRow('Billed Amount',  '₹${collection.amount.toStringAsFixed(0)}'),
      ]),
    );
  }
}

// ── Payment Card ──────────────────────────────────────────────────────────────
class _PaymentCard extends StatefulWidget {
  final SampleCollectionModel collection;
  final String collectionId;
  const _PaymentCard({required this.collection, required this.collectionId});

  @override
  State<_PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<_PaymentCard> {
  final _invoiceCtrl = TextEditingController();
  final _amountCtrl  = TextEditingController();
  final _remarksCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _invoiceCtrl.text = widget.collection.invoiceNo;
    _amountCtrl.text  = widget.collection.amount.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _invoiceCtrl.dispose();
    _amountCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentProvider>();

    return _InfoCard(
      title: 'Payment Entry',
      icon: Icons.receipt_long_rounded,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // ── Payment toggle ──────────────────────────────────
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: provider.paymentReceived
                ? const Color(0xFF0B833D).withOpacity(0.05)
                : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: provider.paymentReceived
                  ? const Color(0xFF0B833D).withOpacity(0.20)
                  : const Color(0xFFE9ECEF),
            ),
          ),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Payment Received?',
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF212529))),
              Text(
                provider.paymentReceived ? 'Mark payment details below' : 'Toggle to enter payment',
                style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD)),
              ),
            ])),
            Switch(
              value: provider.paymentReceived,
              onChanged: context.read<PaymentProvider>().togglePaymentReceived,
              activeColor: const Color(0xFF0B833D),
            ),
          ]),
        ),
        const SizedBox(height: 20),

        if (provider.paymentReceived) ...[
          _label('Invoice Number *'),
          const SizedBox(height: 6),
          TextField(
            controller: _invoiceCtrl,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
            decoration: _inputDecor('e.g. INV-2025-001', prefixIcon: Icons.receipt_outlined),
          ),
          const SizedBox(height: 16),

          _label('Amount Received (₹) *'),
          const SizedBox(height: 6),
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            style: GoogleFonts.inter(fontSize: 14),
            decoration: _inputDecor('Enter amount', prefixIcon: Icons.currency_rupee_rounded),
          ),
          const SizedBox(height: 16),

          _label('Payment Mode'),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: provider.paymentModes.map((m) => InkWell(
              onTap: () => context.read<PaymentProvider>().setPaymentMode(m),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: provider.paymentMode == m ? const Color(0xFF0B833D) : const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: provider.paymentMode == m ? const Color(0xFF0B833D) : const Color(0xFFE9ECEF),
                  ),
                ),
                child: Text(m, style: GoogleFonts.inter(
                  fontSize: 12, fontWeight: FontWeight.w600,
                  color: provider.paymentMode == m ? Colors.white : const Color(0xFF495057),
                )),
              ),
            )).toList(),
          ),
          const SizedBox(height: 16),

          _label('Payment Date'),
          const SizedBox(height: 6),
          InkWell(
            onTap: () async {
              final payProvider = context.read<PaymentProvider>();
              final d = await showDatePicker(
                context: context, initialDate: payProvider.paymentDate,
                firstDate: DateTime(2020), lastDate: DateTime.now(),
                builder: (ctx, child) =>
                    Theme(data: ThemeData(colorSchemeSeed: const Color(0xFF0B833D)), child: child!),
              );
              if (d != null) payProvider.setPaymentDate(d);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE9ECEF)),
              ),
              child: Row(children: [
                const Icon(Icons.calendar_today_rounded, size: 16, color: Color(0xFF0B833D)),
                const SizedBox(width: 10),
                Text(_fmt(provider.paymentDate),
                    style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF212529))),
              ]),
            ),
          ),
          const SizedBox(height: 16),

          _label('Remarks (optional)'),
          const SizedBox(height: 6),
          TextField(
            controller: _remarksCtrl,
            maxLines: 2,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: _inputDecor('Any notes about this payment...', prefixIcon: null),
          ),
          const SizedBox(height: 24),
        ] else ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFDD6B20).withOpacity(0.25)),
            ),
            child: Row(children: [
              const Icon(Icons.info_outline_rounded, color: Color(0xFFDD6B20), size: 16),
              const SizedBox(width: 8),
              Expanded(child: Text(
                'Payment not yet received. Toggle above to enter payment details.',
                style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFDD6B20)),
              )),
            ]),
          ),
          const SizedBox(height: 24),
        ],

        // ── Save Button ─────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: provider.saved ? null : () {
              // 1. Save via PaymentProvider (mutates allCollections)
              context.read<PaymentProvider>().savePayment(
                collectionId: widget.collectionId,
                invoiceNo:    _invoiceCtrl.text,
                amount:       double.tryParse(_amountCtrl.text) ?? widget.collection.amount,
                remarks:      _remarksCtrl.text,
              );

              // 2. ✅ FIX: notify CollectionProvider so its filteredCollections
              //    re-reads the now-updated allCollections list
              try {
                context.read<CollectionProvider>().notifyListeners();
              } catch (_) {
                // CollectionProvider not in scope from this route — that's fine,
                // it will re-read allCollections fresh on next navigation
              }

              // 3. Show snackbar
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(children: [
                  const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(
                    provider.paymentReceived
                        ? 'Payment saved — Invoice ${_invoiceCtrl.text}'
                        : 'Record updated successfully',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  )),
                ]),
                backgroundColor: const Color(0xFF0B833D),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              ));

              // 4. Navigate back after snackbar
              Future.delayed(const Duration(seconds: 2), () {
                if (context.mounted) context.go('/collections');
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B833D),
              disabledBackgroundColor: const Color(0xFF0B833D).withOpacity(0.5),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(provider.paymentReceived ? Icons.save_rounded : Icons.update_rounded, size: 18),
              const SizedBox(width: 8),
              Text(
                provider.paymentReceived ? 'Save Payment' : 'Update Record',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ── Info Card Wrapper ─────────────────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _InfoCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, size: 16, color: const Color(0xFF0B833D)),
          const SizedBox(width: 8),
          Text(title, style: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF212529))),
        ]),
        const SizedBox(height: 16),
        const Divider(color: Color(0xFFF1F3F5), height: 1),
        const SizedBox(height: 16),
        child,
      ]),
    );
  }
}

// ── Shared Helpers ────────────────────────────────────────────────────────────
Widget _infoRow(String label, String value) => Padding(
  padding: const EdgeInsets.only(bottom: 10),
  child: Row(children: [
    SizedBox(
      width: 120,
      child: Text(label,
          style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFADB5BD), fontWeight: FontWeight.w500)),
    ),
    Expanded(child: Text(value,
        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529)))),
  ]),
);

Widget _label(String text) => Text(text,
    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF212529)));

InputDecoration _inputDecor(String hint, {IconData? prefixIcon}) => InputDecoration(
  hintText: hint,
  hintStyle: GoogleFonts.inter(fontSize: 13, color: const Color(0xFFADB5BD)),
  prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 17, color: const Color(0xFFADB5BD)) : null,
  filled: true, fillColor: const Color(0xFFF8F9FA),
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  border:        OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE9ECEF))),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF0B833D), width: 1.5)),
);

String _fmt(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';