import 'package:flutter/material.dart';

enum ExpenseType { whitdrawal, increase }

extension XExpenseType on ExpenseType {
  bool isWithdrawal() => this == ExpenseType.whitdrawal;
  String value() => isWithdrawal() ? 'withdrawal' : 'increase';
}

class Expense {
  final String description;
  final String date;
  final double amount;
  final ExpenseType type;

  Expense({
    @required this.description,
    @required this.date,
    @required this.amount,
    @required this.type,
  })  : assert(description != null),
        assert(date != null),
        assert(type != null),
        assert(amount != null);
}
