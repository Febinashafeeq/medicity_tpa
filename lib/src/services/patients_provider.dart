import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../features/mainShell/models/models.dart';

class PatientProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────
  final List<PatientModel> _patients = [];
  DateTime _selectedDate = DateTime.now();
  bool _showAddPatient   = false;
  bool _loading          = false;
  String? _error;

  // ── Getters ────────────────────────────────────────────────
  DateTime get selectedDate => _selectedDate;
  bool get showAddPatient   => _showAddPatient;
  bool get loading          => _loading;
  String? get error         => _error;

  List<PatientModel> patientsForCompany(String companyId) =>
      _patients.where((p) => p.companyId == companyId).toList();

  PatientModel? getPatientById(String id) {
    try { return _patients.firstWhere((p) => p.id == id); }
    catch (_) { return null; }
  }

  List<SampleCollectionModel> collectionsForCompanyOnDate(String companyId) {
    final patientIds = patientsForCompany(companyId).map((p) => p.id).toSet();
    return allCollections.where((c) =>
    patientIds.contains(c.patientId) &&
        c.date.year  == _selectedDate.year  &&
        c.date.month == _selectedDate.month &&
        c.date.day   == _selectedDate.day).toList();
  }

  ({int total, int paid, int unpaid, double amount}) summaryForCompany(String companyId) {
    final cols = collectionsForCompanyOnDate(companyId);
    return (
    total:  cols.length,
    paid:   cols.where((c) =>  c.paymentReceived).length,
    unpaid: cols.where((c) => !c.paymentReceived).length,
    amount: cols.fold(0.0, (s, c) => s + c.amount),
    );
  }

  // ── Fetch from Firestore ───────────────────────────────────
  Future<void> fetchPatients({String? companyId}) async {
    _loading = true;
    _error   = null;
    notifyListeners();

    try {
      // FIX: no orderBy — avoids index errors if createdAt is missing
      Query query = FirebaseFirestore.instance.collection('patients');
      if (companyId != null && companyId.isNotEmpty) {
        query = query.where('companyId', isEqualTo: companyId);
      }

      final snapshot = await query.get();
      print('✅ fetchPatients called with companyId: $companyId');
      print('✅ docs found: ${snapshot.docs.length}');
      _patients
        ..clear()
        ..addAll(snapshot.docs.map((doc) {
          final d = doc.data() as Map<String, dynamic>;
          return PatientModel(
            id:          d['id']          ?? doc.id,
            companyId:   d['companyId']   ?? '',
            companyName: d['companyName'] ?? '',
            tpaId:       d['tpaId']       ?? '',
            tpaName:     d['tpaName']     ?? '',
            name:        d['name']        ?? '',
            age:         (d['age'] as num?)?.toInt() ?? 0,
            gender:      d['gender']      ?? '',
            policyNo:    d['policyNo']    ?? '',
            cardNo:      d['cardNo']      ?? '',
            phone:       d['phone']       ?? '',
            address:     d['address']     ?? '',
            visitType:   d['visitType']   ?? 'Home',
          );
        }));

      // Sync global list
      allPatients
        ..clear()
        ..addAll(_patients);

    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ── Actions ────────────────────────────────────────────────
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

    // Optimistically add locally
    final newPatient = PatientModel(
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
      visitType:   visitType,
    );

    _patients.insert(0, newPatient);
    allPatients.insert(0, newPatient);

    _showAddPatient = false;
    notifyListeners();
  }
}
