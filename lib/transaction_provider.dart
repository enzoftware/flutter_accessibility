import 'package:flutter/material.dart';
import 'data/transaction_data.dart';
import 'domain/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  late List<Transaction> _transactions;
  List<Transaction> get transactions => _transactions;

  late double _balanceAmount;
  double get balanceAmount => _balanceAmount;

  final EMPTY_TOTAL_AMOUNT = 0.0;

  TransactionProvider() {
    _transactions = testTransactionsData;
  }

  void calculateBalanceAmount() {
    _balanceAmount = _transactions.fold(
      EMPTY_TOTAL_AMOUNT,
      (sum, e) => sum += e.type.isExpense() ? e.amount * -1.0 : e.amount,
    );
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
