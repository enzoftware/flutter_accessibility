import 'package:flutter_expense_tracker/domain/expense.dart';

final testExpensesData = [
  Expense(
    amount: 100.0,
    description: 'University',
    date: '12/12/2020',
    type: ExpenseType.increase,
  ),
  Expense(
    amount: 200.0,
    description: 'Gym',
    date: '01/01/2021',
    type: ExpenseType.whitdrawal,
  ),
  Expense(
    amount: 300.0,
    description: 'Food',
    date: '01/02/2021',
    type: ExpenseType.increase,
  ),
];
