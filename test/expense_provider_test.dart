import 'package:flutter_transaction_tracker/domain/transaction.dart';
import 'package:flutter_transaction_tracker/transaction_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TransactionProvider provider;
  final incomeTransaction = Transaction(
    amount: 100.0,
    description: 'Cat food',
    date: '2021-02-04',
    type: TransactionType.income,
  );
  final expenseTransaction = Transaction(
    amount: 100,
    date: '2020-12-12',
    description: 'Test',
    type: TransactionType.expense,
  );
  setUp(() {
    provider = TransactionProvider()..calculateExpenseAmount();
  });
  test('ExpenseBloc initialize with 3 expenses', () {
    expect(provider.transactions, isNotNull);
    expect(provider.transactions.length, 3);
  });

  test('Add new expense to list success', () {
    provider.addExpense(incomeTransaction);
    expect(provider.transactions, isNotNull);
    expect(provider.transactions.length, 4);
  });

  test('On add expense of type withdrawal the amount updates success', () {
    final amountExpenses = provider.balanceAmount;
    provider.addExpense(expenseTransaction);
    provider.calculateExpenseAmount();
    expect(provider.balanceAmount, isNotNull);
    expect(provider.balanceAmount, amountExpenses - expenseTransaction.amount);
  });

  test('On add expense of type increase the amount updates success', () {
    final amountExpenses = provider.balanceAmount;
    provider.addExpense(incomeTransaction);
    provider.calculateExpenseAmount();
    expect(provider.balanceAmount, isNotNull);
    expect(provider.balanceAmount, amountExpenses + incomeTransaction.amount);
  });
}
