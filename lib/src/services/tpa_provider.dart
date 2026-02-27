import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../features/mainShell/models/models.dart';
import '../features/mainShell/ui/tpa/tpa_detail_screen.dart';
import '../features/mainShell/ui/tpa/tpa_list_screen.dart';


class TpaProvider extends ChangeNotifier {

  final db = FirebaseFirestore.instance;
  List<TpaModel> _tpas = [];
  bool isLoading = false;

  // ── State ─────────────────────────────────────────────────────────────────

  List<InsuranceCompanyModel> _companies   = List.from(allCompanies);
  List<PatientModel>          _patients    = List.from(allPatients);
  List<SampleCollectionModel> _collections = List.from(allCollections);

  DateTime _selectedDate     = DateTime.now();
  String   _tpaSearchQuery   = '';
  String   _collectionFilter = 'All'; // All | Paid | Unpaid
  bool     _showAddTpa       = false;
  bool     _showAddCompany   = false;
  bool     _showAddPatient   = false;

  // ── Basic Getters ─────────────────────────────────────────────────────────
  List<TpaModel>              get tpas        => _tpas;
  List<InsuranceCompanyModel> get companies   => _companies;
  List<PatientModel>          get patients    => _patients;
  List<SampleCollectionModel> get collections => _collections;

  DateTime get selectedDate     => _selectedDate;
  String   get collectionFilter => _collectionFilter;
  bool     get showAddTpa       => _showAddTpa;
  bool     get showAddCompany   => _showAddCompany;
  bool     get showAddPatient   => _showAddPatient;

  // ── Filtered TPAs ─────────────────────────────────────────────────────────
  List<TpaModel> get filteredTpas {
    if (_tpaSearchQuery.isEmpty) return _tpas;
    final q = _tpaSearchQuery.toLowerCase();
    return _tpas.where((t) =>
    t.name.toLowerCase().contains(q) ||
        t.code.toLowerCase().contains(q) ||
        t.city.toLowerCase().contains(q)).toList();
  }

  // ── Relational Getters ────────────────────────────────────────────────────
  List<InsuranceCompanyModel> companiesForTpa(String tpaId) =>
      _companies.where((c) => c.tpaId == tpaId).toList();

  List<PatientModel> patientsForCompany(String companyId) =>
      _patients.where((p) => p.companyId == companyId).toList();

  List<SampleCollectionModel> collectionsForDate(String companyId, DateTime date) {
    final patientIds = patientsForCompany(companyId).map((p) => p.id).toSet();
    return _collections.where((c) =>
    patientIds.contains(c.patientId) &&
        c.date.year  == date.year  &&
        c.date.month == date.month &&
        c.date.day   == date.day).toList();
  }

  // ── Daily Collections (global, with filter) ───────────────────────────────
  List<SampleCollectionModel> get allDailyCollections {
    final list = _collections.where((c) =>
    c.date.year  == _selectedDate.year  &&
        c.date.month == _selectedDate.month &&
        c.date.day   == _selectedDate.day).toList();
    if (_collectionFilter == 'Paid')   return list.where((c) =>  c.paymentReceived).toList();
    if (_collectionFilter == 'Unpaid') return list.where((c) => !c.paymentReceived).toList();
    return list;
  }

  // ── Single Item Getters ───────────────────────────────────────────────────
// In TpaProvider
  TpaModel? tpaById(String id) {
    try {
      return _tpas.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  InsuranceCompanyModel companyById(String id) =>
      _companies.firstWhere((c) => c.id == id, orElse: () => _companies.first);

  PatientModel patientById(String id) =>
      _patients.firstWhere((p) => p.id == id, orElse: () => _patients.first);

  SampleCollectionModel collectionById(String id) =>
      _collections.firstWhere((c) => c.id == id, orElse: () => _collections.first);

  // ── Count / Stats Getters ─────────────────────────────────────────────────
  int get totalTpas      => _tpas.length;
  int get activeTpas     => _tpas.where((t) => t.isActive).length;
  int get inactiveTpas   => _tpas.where((t) => !t.isActive).length;
  int get totalCompanies => _companies.length;
  int get totalPatients  => _patients.length;

  int get pendingPayments => _collections.where((c) => !c.paymentReceived).length;

  int get todayCollections {
    final now = DateTime.now();
    return _collections.where((c) =>
    c.date.year  == now.year  &&
        c.date.month == now.month &&
        c.date.day   == now.day).length;
  }

  double get todayAmount {
    final now = DateTime.now();
    return _collections
        .where((c) =>
    c.date.year  == now.year  &&
        c.date.month == now.month &&
        c.date.day   == now.day)
        .fold(0.0, (s, c) => s + c.amount);
  }

  double get totalReceived => _collections
      .where((c) => c.paymentReceived)
      .fold(0.0, (s, c) => s + c.amount);

  // ── TPA Actions ───────────────────────────────────────────────────────────
  void searchTpa(String q) {
    _tpaSearchQuery = q;
    notifyListeners();
  }

  void toggleAddTpa() {
    _showAddTpa = !_showAddTpa;
    notifyListeners();
  }

  void closeAddTpa() {
    _showAddTpa = false;
    notifyListeners();
  }

  Future<void> addTpa({
    required String name,
    required String code,
    required String contactPerson,
    required String phone,
    required String city,
  }) async {
    final String key = DateTime.now().microsecondsSinceEpoch.toString();

    await FirebaseFirestore.instance.collection('tpas').doc(key).set({
      'id':            key,
      'name':          name,
      'code':          code,
      'contactPerson': contactPerson,
      'phone':         phone,
      'city':          city,
      'isActive':      true,
      'companyCount':  0,
      'createdAt':     FieldValue.serverTimestamp(),
    });

    _tpas.insert(0, TpaModel(
      id:            key,
      name:          name,
      code:          code,
      contactPerson: contactPerson,
      phone:         phone,
      city:          city,
      isActive:      true,
      companyCount:  0,
    ));

    _showAddTpa = false;
    notifyListeners();
  }

  Future<void> fetchTpas() async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot = await db.collection('tpas').get();
      _tpas = snapshot.docs.map((doc) =>
          TpaModel.fromMap(doc.id, doc.data())
      ).toList();
    } catch (e) {
      debugPrint('fetchTpas error: $e');
    }

    isLoading = false;
    notifyListeners();
  }


  // ── Company Actions ───────────────────────────────────────────────────────
  void toggleAddCompany() {
    _showAddCompany = !_showAddCompany;
    notifyListeners();
  }

  void closeAddCompany() {
    _showAddCompany = false;
    notifyListeners();
  }

  void addCompany({
    required String tpaId,
    required String name,
    required String policyType,
    required String empanelmentNo,
    required String contactPerson,
    required String phone,
  }) {
    _companies = [
      ..._companies,
      InsuranceCompanyModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        tpaId: tpaId, name: name, policyType: policyType,
        empanelmentNo: empanelmentNo, contactPerson: contactPerson,
        phone: phone, isActive: true, patientCount: 0,
      ),
    ];
    _showAddCompany = false;
    notifyListeners();
  }

  // ── Patient Actions ───────────────────────────────────────────────────────
  void toggleAddPatient() {
    _showAddPatient = !_showAddPatient;
    notifyListeners();
  }

  void closeAddPatient() {
    _showAddPatient = false;
    notifyListeners();
  }

  void addPatient({
    required String companyId,
    required String name,
    required int    age,
    required String gender,
    required String policyNo,
    required String cardNo,
    required String phone,
    required String address,
  }) {
    _patients = [
      ..._patients,
      PatientModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        companyId: companyId, name: name, age: age, gender: gender,
        policyNo: policyNo, cardNo: cardNo, phone: phone, address: address,
      ),
    ];
    _showAddPatient = false;
    notifyListeners();
  }

  // ── Collection / Date / Filter Actions ───────────────────────────────────
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setCollectionFilter(String filter) {
    _collectionFilter = filter;
    notifyListeners();
  }

  // ── Save Payment ──────────────────────────────────────────────────────────
  void savePayment({
    required String collectionId,
    required bool   paymentReceived,
    required String invoiceNo,
    required double amount,
    required String paymentMode,
  }) {
    _collections = _collections.map((c) {
      if (c.id != collectionId) return c;
      return SampleCollectionModel(
        id: c.id, patientId: c.patientId, companyId: c.companyId,
        date: c.date, tests: c.tests, sampleStatus: c.sampleStatus,
        paymentReceived: paymentReceived, invoiceNo: invoiceNo,
        amount: amount, paymentMode: paymentMode,
      );
    }).toList();
    notifyListeners();
  }
}

