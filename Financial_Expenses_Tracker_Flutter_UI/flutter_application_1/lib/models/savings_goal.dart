class SavingsGoal {
  final int id;
  final double targetAmount;
  final double savedAmount;

  SavingsGoal({
    required this.id,
    required this.targetAmount,
    required this.savedAmount,
  });

  factory SavingsGoal.fromJson(Map<String, dynamic> json) {
    return SavingsGoal(
      id: json['id'],
      targetAmount: (json['targetAmount'] as num).toDouble(),
      savedAmount: (json['saved'] as num).toDouble(),
    );
  }
}
