import 'package:flutter/material.dart';
import 'package:flutter_transaction_tracker/transaction_screen.dart';
import 'package:flutter_transaction_tracker/transaction_provider.dart';
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
      title: 'TransactionTrackerApp',
      // This will force Flutter to generate
      //  an overlay to visualize the Semantics tree.
      showSemanticsDebugger: true,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      home: ChangeNotifierProvider(
        create: (_) => TransactionProvider(),
        builder: (_, __) => const ExpenseScreen(),
      ),
    );
  }
}
