import 'package:flutter_transaction_tracker/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('bySemanticsLabel test', (WidgetTester tester) async {
    await tester.pumpWidget(const TransactionTrackerApp());
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel(RegExp('Transaction')), findsNWidgets(3));
  });
}
