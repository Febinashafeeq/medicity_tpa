import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> addPatient({
    required String companyId,
    required String companyName,
    required String tpaId,
    required String tpaName,
    required String name,
    required int    age,
    required String gender,
    required String policyNo,
    required String cardNo,
    required String phone,
    required String address,
    required String visitType,
  }) async {
    final String key = DateTime.now().microsecondsSinceEpoch.toString();

    await FirebaseFirestore.instance.collection('patients').doc(key).set({
      'id':          key,
      'companyId':   companyId,
      'companyName': companyName,
      'tpaId':       tpaId,
      'tpaName':     tpaName,
      'name':        name,
      'age':         age,
      'gender':      gender,
      'visitType':   visitType,
      'policyNo':    policyNo,
      'cardNo':      cardNo,
      'phone':       phone,
      'address':     address,
      'createdAt':   FieldValue.serverTimestamp(),
    });

    _patients.insert(0, PatientModel(
      id:          key,
      companyId:   companyId,
      companyName: companyName,
      tpaId:       tpaId,
      tpaName:     tpaName,
      name:        name,
      age:         age,
      gender:      gender,
      policyNo:    policyNo,
      cardNo:      cardNo,
      phone:       phone,
      address:     address,
      visitType:   visitType
    ));

    _showAddPatient = false;
    notifyListeners();
  }
}