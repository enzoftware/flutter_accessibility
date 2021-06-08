enum TransactionType { expense, income }

extension XExpenseType on TransactionType {
  bool isExpense() => this == TransactionType.expense;

  String value() => isExpense() ? 'expense' : 'income';
}

class Transaction {
  final String description;
  final String date;
  final double amount;
  final TransactionType type;

  Transaction({
    required this.description,
    required this.date,
    required this.amount,
    required this.type,
  });
}
