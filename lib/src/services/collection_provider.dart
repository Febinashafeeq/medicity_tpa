import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../features/mainShell/models/models.dart';


class CollectionProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────
  final List<SampleCollectionModel> _collections = [];
  final List<PatientModel>          _patients    = [];
  final List<InsuranceCompanyModel> _companies   = [];

  DateTime _selectedDate = DateTime.now();
  String   _filterStatus = 'All'; // 'All' | 'Paid' | 'Unpaid'
  bool     _loading      = false;
  String?  _error;

  // ── Getters ────────────────────────────────────────────────
  DateTime get selectedDate => _selectedDate;
  String   get filterStatus => _filterStatus;
  bool     get loading      => _loading;
  String?  get error        => _error;

  // Look up patient/company by id from local cache
  PatientModel? patientById(String id) {
    try { return _patients.firstWhere((p) => p.id == id); }
    catch (_) { return null; }
  }

  InsuranceCompanyModel? companyById(String id) {
    try { return _companies.firstWhere((c) => c.id == id); }
    catch (_) { return null; }
  }

  List<SampleCollectionModel> get filteredCollections {
    return _collections.where((c) {
      final dateMatch =
          c.date.year  == _selectedDate.year  &&
              c.date.month == _selectedDate.month &&
              c.date.day   == _selectedDate.day;
      final statusMatch =
          _filterStatus == 'All' ||
              (_filterStatus == 'Paid'   &&  c.paymentReceived) ||
              (_filterStatus == 'Unpaid' && !c.paymentReceived);
      return dateMatch && statusMatch;
    }).toList();
  }

  ({int total, int paid, int unpaid, double amount}) get summary {
    final cols = filteredCollections;
    return (
    total:  cols.length,
    paid:   cols.where((c) =>  c.paymentReceived).length,
    unpaid: cols.where((c) => !c.paymentReceived).length,
    amount: cols.fold(0.0, (s, c) => s + c.amount),
    );
  }

  // ── Fetch everything from Firestore ────────────────────────
  Future<void> fetchAll() async {
    _loading = true;
    _error   = null;
    notifyListeners();

    try {
      // 1. Fetch collections
      final colSnap = await FirebaseFirestore.instance
          .collection('collections')
          .orderBy('date', descending: true)
          .get();

      _collections
        ..clear()
        ..addAll(colSnap.docs.map((doc) {
          final d = doc.data();
          return SampleCollectionModel(
            id:             d['id']             ?? doc.id,
            patientId:      d['patientId']      ?? '',
            companyId:      d['companyId']      ?? '',
            date:           (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
            tests:          d['tests']          ?? '',
            sampleStatus:   d['sampleStatus']   ?? 'Collected',
            amount:         (d['amount'] as num?)?.toDouble() ?? 0.0,
            paymentReceived: d['paymentReceived'] ?? false,
            invoiceNo:      d['invoiceNo']      ?? '',
            paymentMode:    d['paymentMode']    ?? '',
          );
        }));

      // Also sync global list so PaymentEntryScreen can read it
      allCollections
        ..clear()
        ..addAll(_collections);

      // 2. Fetch patients (needed for name lookups in rows)
      final patSnap = await FirebaseFirestore.instance
          .collection('patients')
          .get();

      _patients
        ..clear()
        ..addAll(patSnap.docs.map((doc) {
          final d = doc.data();
          return PatientModel(
            id:          d['id']          ?? doc.id,
            companyId:   d['companyId']   ?? '',
            companyName: d['companyName'] ?? '',
            tpaId:       d['tpaId']       ?? '',
            tpaName:     d['tpaName']     ?? '',
            name:        d['name']        ?? '',
            age:         d['age']         ?? 0,
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

      // 3. Fetch companies (needed for company name lookup)
      final compSnap = await FirebaseFirestore.instance
          .collection('companies')
          .get();

      _companies
        ..clear()
        ..addAll(compSnap.docs.map((doc) {
          final d = doc.data();
          return InsuranceCompanyModel(
            id:            d['id']            ?? doc.id,
            tpaId:         d['tpaId']         ?? '',
            name:          d['name']          ?? '',
            policyType:    d['policyType']    ?? '',
            empanelmentNo: d['empanelmentNo'] ?? '',
            contactPerson: d['contactPerson'] ?? '',
            phone:         d['phone']         ?? '',
            isActive:      d['isActive']      ?? true,
            patientCount:  d['patientCount']  ?? 0,
          );
        }));

      allCompanies
        ..clear()
        ..addAll(_companies);

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

  void setFilterStatus(String status) {
    _filterStatus = status;
    notifyListeners();
  }

  // Called after PaymentEntryScreen saves — re-reads updated allCollections
  void refreshFromGlobal() {
    _collections
      ..clear()
      ..addAll(allCollections);
    notifyListeners();
  }
}