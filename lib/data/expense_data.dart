import 'package:flutter_expense_tracker/domain/expense.dart';

final testExpensesData = [
  Expense(
    amount: 1292.1,
    description: 'University',
    date: '12/12/2020',
    type: ExpenseType.increase,
  ),
  Expense(
    amount: 122.1,
    description: 'Gym',
    date: '01/01/2021',
    type: ExpenseType.whitdrawal,
  ),
  Expense(
    amount: 10.5,
    description: 'Food',
    date: '01/02/2021',
    type: ExpenseType.increase,
  ),
];

final expenseTest = Expense(
  amount: 100.0,
  description: 'Cat food',
  date: '04/02/2021',
  type: ExpenseType.increase,
);
