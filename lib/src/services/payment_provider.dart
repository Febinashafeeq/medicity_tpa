import 'package:flutter/material.dart';
import '../features/mainShell/models/models.dart';


class PaymentProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────────────────────
  bool _paymentReceived = false;
  String _paymentMode = 'Cash';
  DateTime _paymentDate = DateTime.now();
  bool _saved = false;

  final List<String> paymentModes = ['Cash', 'NEFT', 'RTGS', 'Cheque', 'TPA Credit', 'UPI'];

  // ── Getters ────────────────────────────────────────────────────────────────
  bool get paymentReceived => _paymentReceived;
  String get paymentMode => _paymentMode;
  DateTime get paymentDate => _paymentDate;
  bool get saved => _saved;

  // ── Init from existing collection ──────────────────────────────────────────
  void initFromCollection(SampleCollectionModel c) {
    _paymentReceived = c.paymentReceived;
    _paymentMode = c.paymentMode.isEmpty ? 'Cash' : c.paymentMode;
    _paymentDate = DateTime.now();
    _saved = false;
    notifyListeners();
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  void togglePaymentReceived(bool value) {
    _paymentReceived = value;
    notifyListeners();
  }

  void setPaymentMode(String mode) {
    _paymentMode = mode;
    notifyListeners();
  }

  void setPaymentDate(DateTime date) {
    _paymentDate = date;
    notifyListeners();
  }

  void savePayment({
    required String collectionId,
    required String invoiceNo,
    required double amount,
    required String remarks,
  }) {
    // Update the global collection list
    final index = allCollections.indexWhere((c) => c.id == collectionId);
    if (index != -1) {
      allCollections[index] = allCollections[index].copyWith(
        paymentReceived: _paymentReceived,
        invoiceNo: invoiceNo,
        paymentMode: _paymentMode,
        amount: amount,
      );
    }
    _saved = true;
    notifyListeners();
  }

  void reset() {
    _paymentReceived = false;
    _paymentMode = 'Cash';
    _paymentDate = DateTime.now();
    _saved = false;
    notifyListeners();
  }
}