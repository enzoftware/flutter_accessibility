import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      showSemanticsDebugger: true,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      home: ChangeNotifierProvider(
        create: (_) => TransactionProvider(),
        builder: (_, __) => const TransactionScreen(),
      ),
    );
  }
}
