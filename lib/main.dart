import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/expense_bloc.dart';
import 'package:flutter_expense_tracker/expense_screen.dart';
import 'package:google_fonts/google_fonts.dart';
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
      // This will force Flutter to generate
      //  an overlay to visualize the Semantics tree.
      // showSemanticsDebugger: true,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      home: ChangeNotifierProvider(
        create: (_) => ExpenseBloc(),
        builder: (_, __) => const ExpenseScreen(),
      ),
    );
  }
}
