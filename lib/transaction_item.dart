import 'package:flutter/material.dart';
import 'domain/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final type = transaction.type.value();
    final amount = transaction.amount;
    final date = transaction.date;
    return Semantics(
      label: 'Transaction $type of $amount on $date',
      child: ListTile(
        leading: TransactionIndicator(transactionType: transaction.type),
        title: Text(transaction.description),
        subtitle: Text(transaction.date),
        trailing: Text(transaction.amount.toString()),
      ),
    );
  }
}

class TransactionIndicator extends StatelessWidget {
  final TransactionType transactionType;

  const TransactionIndicator({Key? key, required this.transactionType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final indicatorColor =
        transactionType.isExpense() ? Colors.red : Colors.blue;
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: indicatorColor),
    );
  }
}
