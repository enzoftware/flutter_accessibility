import 'package:flutter_expense_tracker/domain/expense.dart';
import 'package:flutter_expense_tracker/expense_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ExpenseProvider provider;
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
    type: ExpenseType.whitdrawal,
  );
  setUp(() {
    provider = ExpenseProvider()..calculateExpenseAmount();
  });
  test('ExpenseBloc initialize with 3 expenses', () {
    expect(provider.expenses, isNotNull);
    expect(provider.expenses.length, 3);
  });

  test('Add new expense to list success', () {
    provider.addExpense(increaseExpense);
    expect(provider.expenses, isNotNull);
    expect(provider.expenses.length, 4);
  });

  test('On add expense of type withdrawal the amount updates success', () {
    final amountExpenses = provider.expenseTotalAmount;
    provider.addExpense(withdrawalExpense);
    provider.calculateExpenseAmount();
    expect(provider.expenseTotalAmount, isNotNull);
    expect(
        provider.expenseTotalAmount, amountExpenses - withdrawalExpense.amount);
  });

  test('On add expense of type increase the amount updates success', () {
    final amountExpenses = provider.expenseTotalAmount;
    provider.addExpense(increaseExpense);
    provider.calculateExpenseAmount();
    expect(provider.expenseTotalAmount, isNotNull);
    expect(
        provider.expenseTotalAmount, amountExpenses + increaseExpense.amount);
  });
}
