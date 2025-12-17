class Expense {
  final int id;
  final double amount;
  final String category;
  final String description;
  final String expenseDate;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.expenseDate,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      expenseDate: json['expenseDate'] ?? '',
    );
  }
}
