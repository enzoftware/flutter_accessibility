import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/domain/expense.dart';
import 'package:flutter_expense_tracker/expense_bloc.dart';
import 'package:flutter_expense_tracker/expense_item.dart';
import 'package:flutter_expense_tracker/expense_modal.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ExpenseBloc>()..calculateExpenseAmount();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ExpenseAmount(amount: bloc.expenseTotalAmount),
            Expanded(
              child: Semantics(
                label: 'List of expenses',
                child: ExpenseListBody(expenses: bloc.expenses),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
            semanticLabel: 'Add icon',
          ),
          tooltip: 'Add new expense',
          onPressed: () => ExpenseModal.show(
            context,
            onButtonPressed: (expense) => bloc.addExpense(expense),
          ),
        ),
      ),
    );
  }
}

class ExpenseAmount extends StatelessWidget {
  final double amount;
  const ExpenseAmount({Key key, this.amount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 96.0, bottom: 64),
        child: Column(
          children: [
            const ExcludeSemantics(
              child: Text(
                'This month',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Text(
              amount.toString(),
              semanticsLabel:
                  'The expense for this month is ${amount.toString()} dollars',
              style: const TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseListBody extends StatelessWidget {
  final List<Expense> expenses;
  const ExpenseListBody({Key key, this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (_, index) => ExpenseItem(expense: expenses[index]),
    );
  }
}
