import 'package:flutter/material.dart';

import '../features/mainShell/models/models.dart';


class CollectionProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────────────────────
  DateTime _selectedDate = DateTime.now();
  String _filterStatus = 'All'; // 'All' | 'Paid' | 'Unpaid'

  // ── Getters ────────────────────────────────────────────────────────────────
  DateTime get selectedDate => _selectedDate;
  String get filterStatus => _filterStatus;

  List<SampleCollectionModel> get filteredCollections {
    return allCollections.where((c) {
      final dateMatch = c.date.year == _selectedDate.year &&
          c.date.month == _selectedDate.month &&
          c.date.day == _selectedDate.day;
      final statusMatch = _filterStatus == 'All' ||
          (_filterStatus == 'Paid' && c.paymentReceived) ||
          (_filterStatus == 'Unpaid' && !c.paymentReceived);
      return dateMatch && statusMatch;
    }).toList();
  }

  // ── Summary Stats ──────────────────────────────────────────────────────────
  ({int total, int paid, int unpaid, double amount}) get summary {
    final cols = filteredCollections;
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

  void setFilterStatus(String status) {
    _filterStatus = status;
    notifyListeners();
  }
}