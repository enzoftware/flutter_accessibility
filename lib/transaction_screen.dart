import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/transaction.dart';
import 'transaction_item.dart';
import 'transaction_modal.dart';
import 'transaction_provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);
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
          // TODO: Add tooltip option
          onPressed: () => TransactionModal.show(
            context,
            onButtonPressed: (transaction) =>
                provider.addTransaction(transaction),
          ),
        ),
      ),
    );
  }
}

class BalanceAmount extends StatelessWidget {
  final double amount;
  const BalanceAmount({Key? key, required this.amount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 96.0, bottom: 64),
        child: Column(
          children: [
            // TODO: Wrap with ExcludeSemantics
            const Text(
              'This month',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(amount.toString(), style: const TextStyle(fontSize: 48)),
          ],
        ),
      ),
    );
  }
}

class TransactionListBody extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionListBody({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (_, index) =>
          TransactionItem(transaction: transactions[index]),
    );
  }
}
