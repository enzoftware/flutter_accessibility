import 'package:flutter/material.dart';
import 'package:flutter_transaction_tracker/domain/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({Key key, @required this.transaction})
      : assert(transaction != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TransactionIndicator(transactionType: transaction.type),
      title: Text(transaction.description),
      subtitle: Text(transaction.date),
      trailing: Text(transaction.amount.toString()),
    );
  }
}

class TransactionIndicator extends StatelessWidget {
  final TransactionType transactionType;

  const TransactionIndicator({Key key, this.transactionType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final indicatorColor =
        transactionType.isExpense() ? Colors.red : Colors.green;
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: indicatorColor),
    );
  }
}
