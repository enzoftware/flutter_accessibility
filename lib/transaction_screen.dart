import 'package:flutter/material.dart';
import 'package:flutter_transaction_tracker/domain/transaction.dart';
import 'package:flutter_transaction_tracker/transaction_provider.dart';
import 'package:flutter_transaction_tracker/transaction_item.dart';
import 'package:flutter_transaction_tracker/transaction_modal.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>()
      ..calculateBalanceAmount();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BalanceAmount(amount: provider.balanceAmount),
            Expanded(
                child: TransactionListBody(transactions: provider.transactions))
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: 'Add new entry',
          onPressed: () => TransactionModal.show(
            context,
            onButtonPressed: (transaction) {
              provider.addTransaction(transaction);
            },
          ),
        ),
      ),
    );
  }
}

class BalanceAmount extends StatelessWidget {
  final double amount;
  const BalanceAmount({Key key, this.amount}) : super(key: key);
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
                  'The balance for this month is ${amount.toString()} dollars',
              style: const TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionListBody extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionListBody({Key key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (_, index) =>
          TransactionItem(transaction: transactions[index]),
    );
  }
}
