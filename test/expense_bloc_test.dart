import 'package:flutter_expense_tracker/domain/expense.dart';
import 'package:flutter_expense_tracker/expense_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ExpenseBloc bloc;
  final increaseExpense = Expense(
    amount: 100.0,
    description: 'Cat food',
    date: '2021-02-04',
    type: ExpenseType.increase,
  );
  final withdrawalExpense = Expense(
    amount: 100,
    date: '2020-12-12',
    description: 'Test',
    type: ExpenseType.increase,
  );
  setUp(() {
    bloc = ExpenseBloc()..calculateExpenseAmount();
  });
  test('ExpenseBloc initialize with 3 expenses', () {
    expect(bloc.expenses, isNotNull);
    expect(bloc.expenses.length, 3);
  });

  test('Add new expense to list success', () {
    bloc.addExpense(increaseExpense);
    expect(bloc.expenses, isNotNull);
    expect(bloc.expenses.length, 4);
  });

  test('On add expense of type withdrawal the amount updates success', () {
    final amountExpenses = bloc.expenseTotalAmount;
    bloc.addExpense(withdrawalExpense);
    bloc.calculateExpenseAmount();
    expect(bloc.expenseTotalAmount, isNotNull);
    expect(bloc.expenseTotalAmount, amountExpenses + withdrawalExpense.amount);
  });

  test('On add expense of type increase the amount updates success', () {
    final amountExpenses = bloc.expenseTotalAmount;
    bloc.addExpense(increaseExpense);
    bloc.calculateExpenseAmount();
    expect(bloc.expenseTotalAmount, isNotNull);
    expect(bloc.expenseTotalAmount, amountExpenses + increaseExpense.amount);
  });
}
