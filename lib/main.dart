import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/expense_bloc.dart';
import 'package:flutter_expense_tracker/expense_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FlutterExpenseTrackerApp());
}

class FlutterExpenseTrackerApp extends StatelessWidget {
  const FlutterExpenseTrackerApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterExpenseTrackerApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (_) => ExpenseBloc(),
        builder: (_, __) => const ExpenseScreen(),
      ),
    );
  }
}
