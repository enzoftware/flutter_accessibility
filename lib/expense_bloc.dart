import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/data/expense_data.dart';
import 'package:flutter_expense_tracker/domain/expense.dart';

class ExpenseBloc extends ChangeNotifier {
  List<Expense> _expenses;
  List<Expense> get expenses => _expenses;

  double _expenseTotalAmount;
  double get expenseTotalAmount => _expenseTotalAmount;

  final EMPTY_TOTAL_AMOUNT = 0.0;

  ExpenseBloc() {
    _expenses = testExpensesData;
  }

  void calculateExpenseAmount() {
    _expenseTotalAmount = _expenses.fold(
      EMPTY_TOTAL_AMOUNT,
      (sum, e) => sum += e.type.isWithdrawal() ? e.amount * -1.0 : e.amount,
    );
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }
}
