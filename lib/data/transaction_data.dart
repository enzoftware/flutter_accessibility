import 'package:flutter_transaction_tracker/domain/transaction.dart';

final testTransactionsData = [
  Transaction(
    amount: 800.0,
    description: 'Gift',
    date: '12/12/2020',
    type: TransactionType.income,
  ),
  Transaction(
    amount: 200.0,
    description: 'Gym',
    date: '01/01/2021',
    type: TransactionType.expense,
  ),
  Transaction(
    amount: 100.0,
    description: 'Food',
    date: '01/02/2021',
    type: TransactionType.expense,
  ),
];
