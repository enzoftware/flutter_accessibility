import 'package:flutter_transaction_tracker/domain/transaction.dart';
import 'package:flutter_transaction_tracker/transaction_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TransactionProvider provider;
  const incomeTransaction = Transaction(
    amount: 100.0,
    description: 'Cat food',
    date: '2021-02-04',
    type: TransactionType.income,
  );
  const expenseTransaction = Transaction(
    amount: 100,
    date: '2020-12-12',
    description: 'Test',
    type: TransactionType.expense,
  );
  setUp(() {
    provider = TransactionProvider()..calculateBalanceAmount();
  });
  test('Transaction provider initialize with 3 expenses', () {
    expect(provider.transactions, isNotNull);
    expect(provider.transactions.length, 3);
  });

  test('Add new transaction to list success', () {
    provider.addTransaction(incomeTransaction);
    expect(provider.transactions, isNotNull);
    expect(provider.transactions.length, 4);
  });

  test('On add transaction of type expense the amount updates success', () {
    final balance = provider.balanceAmount;
    provider.addTransaction(expenseTransaction);
    provider.calculateBalanceAmount();
    expect(provider.balanceAmount, isNotNull);
    expect(provider.balanceAmount, balance - expenseTransaction.amount);
  });

  test('On add transaction of type income the amount updates success', () {
    final balance = provider.balanceAmount;
    provider.addTransaction(incomeTransaction);
    provider.calculateBalanceAmount();
    expect(provider.balanceAmount, isNotNull);
    expect(provider.balanceAmount, balance + incomeTransaction.amount);
  });
}
