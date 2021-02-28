import 'package:flutter_expense_tracker/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('bySemanticsLabel test', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterExpenseTrackerApp());
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel(RegExp('Expense')), findsNWidgets(3));
  });
}
