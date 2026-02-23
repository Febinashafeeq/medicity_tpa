import 'package:flutter/material.dart';
import '../features/mainShell/models/models.dart';

class PatientProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────────────────────
  final List<PatientModel> _patients = List.from(allPatients);
  DateTime _selectedDate = DateTime.now();
  bool _showAddPatient = false;

  // ── Getters ────────────────────────────────────────────────────────────────
  DateTime get selectedDate => _selectedDate;
  bool get showAddPatient => _showAddPatient;

  List<PatientModel> patientsForCompany(String companyId) =>
      _patients.where((p) => p.companyId == companyId).toList();

  PatientModel? getPatientById(String id) {
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (_) {
      return _patients.isNotEmpty ? _patients.first : null;
    }
  }

  List<SampleCollectionModel> collectionsForCompanyOnDate(String companyId) {
    final patientIds = patientsForCompany(companyId).map((p) => p.id).toSet();
    return allCollections.where((c) =>
    patientIds.contains(c.patientId) &&
        c.date.year == _selectedDate.year &&
        c.date.month == _selectedDate.month &&
        c.date.day == _selectedDate.day).toList();
  }

  // ── Summary Stats ──────────────────────────────────────────────────────────
  ({int total, int paid, int unpaid, double amount}) summaryForCompany(String companyId) {
    final cols = collectionsForCompanyOnDate(companyId);
    return (
    total: cols.length,
    paid: cols.where((c) => c.paymentReceived).length,
    unpaid: cols.where((c) => !c.paymentReceived).length,
    amount: cols.fold(0.0, (s, c) => s + c.amount),
    );
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void toggleAddPatient() {
    _showAddPatient = !_showAddPatient;
    notifyListeners();
  }

  void hideAddPatient() {
    _showAddPatient = false;
    notifyListeners();
  }

  void addPatient(PatientModel patient) {
    _patients.add(patient);
    _showAddPatient = false;
    notifyListeners();
  }
}