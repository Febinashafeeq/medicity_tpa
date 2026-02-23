import 'package:flutter/material.dart';
import '../features/mainShell/models/models.dart';


class InsuranceProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────────────────────
  final List<InsuranceCompanyModel> _companies = List.from(allCompanies);
  bool _showAddForm = false;

  // ── Getters ────────────────────────────────────────────────────────────────
  bool get showAddForm => _showAddForm;

  List<InsuranceCompanyModel> companiesForTpa(String tpaId) =>
      _companies.where((c) => c.tpaId == tpaId).toList();

  int activeCountForTpa(String tpaId) =>
      companiesForTpa(tpaId).where((c) => c.isActive).length;

  InsuranceCompanyModel? getCompanyById(String id) {
    try {
      return _companies.firstWhere((c) => c.id == id);
    } catch (_) {
      return _companies.isNotEmpty ? _companies.first : null;
    }
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  void toggleAddForm() {
    _showAddForm = !_showAddForm;
    notifyListeners();
  }

  void hideAddForm() {
    _showAddForm = false;
    notifyListeners();
  }

  void addCompany(InsuranceCompanyModel company) {
    _companies.add(company);
    _showAddForm = false;
    notifyListeners();
  }
}