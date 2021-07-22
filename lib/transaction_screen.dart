/* Copyright (c) 2021 Razeware LLC

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom
the Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify,
merge, publish, distribute, sublicense, create a derivative work,
and/or sell copies of the Software in any work that is designed,
intended, or marketed for pedagogical or instructional purposes
related to programming, coding, application development, or
information technology. Permission for such use, copying,
modification, merger, publication, distribution, sublicensing,
creation of derivative works, or sale is expressly withheld.

This project and source code may use libraries or frameworks
that are released under various Open-Source licenses. Use of
those libraries and frameworks are governed by their own
individual licenses.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE. */

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
