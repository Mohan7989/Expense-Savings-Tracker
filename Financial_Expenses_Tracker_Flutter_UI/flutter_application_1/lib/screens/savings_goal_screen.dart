import 'package:flutter/material.dart';
import '../models/savings_goal.dart';
import '../services/api_service.dart';
import 'add_saved_amount_screen.dart';
import 'savings_history_screen.dart';

class SavingsGoalsListScreen extends StatefulWidget {
  const SavingsGoalsListScreen({super.key});

  @override
  State<SavingsGoalsListScreen> createState() =>
      _SavingsGoalsListScreenState();
}

class _SavingsGoalsListScreenState extends State<SavingsGoalsListScreen> {
  late Future<List<SavingsGoal>> goalsFuture;

  @override
  void initState() {
    super.initState();
    goalsFuture = ApiService.getAllSavingsGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Savings Goals")),
      body: FutureBuilder<List<SavingsGoal>>(
        future: goalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No savings goals found"));
          }

          final goals = snapshot.data!;

          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final g = goals[index];
              final progress = g.savedAmount / g.targetAmount;

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Target: ₹${g.targetAmount}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Saved: ₹${g.savedAmount}"),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: progress),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AddSavedAmountScreen(goalId: g.id),
                                ),
                              ).then((_) {
                                setState(() {
                                  goalsFuture =
                                      ApiService.getAllSavingsGoals();
                                });
                              });
                            },
                            child: const Text("Add Amount"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      SavingsHistoryScreen(goalId: g.id),
                                ),
                              );
                            },
                            child: const Text("View History"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
