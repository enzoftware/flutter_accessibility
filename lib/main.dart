import 'package:flutter/material.dart';
import 'package:flutter_transaction_tracker/transaction_provider.dart';
import 'package:flutter_transaction_tracker/transaction_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FlutterExpenseTrackerApp());
}

class FlutterExpenseTrackerApp extends StatelessWidget {
  const FlutterExpenseTrackerApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TransactionTrackerApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (_) => TransactionProvider(),
        builder: (_, __) => const ExpenseScreen(),
      ),
    );
  }
}
