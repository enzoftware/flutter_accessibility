import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/domain/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({Key key, @required this.expense})
      : assert(expense != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final expenseTypeValue = expense.type.value();
    final expenseAmount = expense.amount;
    final expenseDate = expense.date;

    return Semantics(
      label: 'Expense $expenseTypeValue of $expenseAmount on $expenseDate',
      child: ListTile(
        leading: ExcludeSemantics(
          child: ExpenseIndicator(expenseType: expense.type),
        ),
        title: ExcludeSemantics(
          child: Text(
            expense.description,
            textScaleFactor: 1.5,
          ),
        ),
        subtitle: ExcludeSemantics(
          child: Text(expense.date),
        ),
        trailing: ExcludeSemantics(
          child: Text(expense.amount.toString()),
        ),
      ),
    );
  }
}

class ExpenseIndicator extends StatelessWidget {
  final ExpenseType expenseType;

  const ExpenseIndicator({Key key, this.expenseType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final indicatorColor =
        expenseType.isWithdrawal() ? Colors.red : Colors.blue;
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: indicatorColor),
    );
  }
}
