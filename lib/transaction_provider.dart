import 'package:flutter/material.dart';
import 'package:flutter_transaction_tracker/data/transaction_data.dart';
import 'package:flutter_transaction_tracker/domain/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions;
  List<Transaction> get transactions => _transactions;

  double _balanceAmount;
  double get balanceAmount => _balanceAmount;

  final EMPTY_TOTAL_AMOUNT = 0.0;

  TransactionProvider() {
    _transactions = testTransactionsData;
  }

  void calculateExpenseAmount() {
    _balanceAmount = _transactions.fold(
      EMPTY_TOTAL_AMOUNT,
      (sum, e) => sum += e.type.isExpense() ? e.amount * -1.0 : e.amount,
    );
  }

  void addExpense(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
