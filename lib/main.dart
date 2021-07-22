import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_provider.dart';
import 'transaction_screen.dart';

void main() {
  runApp(const TransactionTrackerApp());
}

class TransactionTrackerApp extends StatelessWidget {
  const TransactionTrackerApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TransactionTrackerApp',
      // TODO: Add showSemanticsDebugger attribute
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // TODO: Add GoogleFonts custom text theme
      ),
      home: ChangeNotifierProvider(
        create: (_) => TransactionProvider(),
        builder: (_, __) => const TransactionScreen(),
      ),
    );
  }
}
