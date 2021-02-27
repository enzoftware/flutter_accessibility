import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/domain/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({Key key, @required this.expense})
      : assert(expense != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ExpenseIndicator(expenseType: expense.type),
      title: Text(expense.description),
      subtitle: Text(expense.date),
      trailing: Text(expense.amount.toString()),
    );
  }
}

class ExpenseIndicator extends StatelessWidget {
  final ExpenseType expenseType;

  const ExpenseIndicator({Key key, this.expenseType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final indicatorColor =
        expenseType.isWithdrawal() ? Colors.red : Colors.green;
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: indicatorColor),
    );
  }
}
