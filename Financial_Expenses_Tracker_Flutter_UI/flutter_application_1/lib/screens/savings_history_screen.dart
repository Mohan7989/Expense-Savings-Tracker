import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SavingsHistoryScreen extends StatelessWidget {
  final int goalId;

  const SavingsHistoryScreen({super.key, required this.goalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Savings History")),
      body: FutureBuilder<List<double>>(
        future: ApiService.getSavingsHistory(goalId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          


          final list = snapshot.data!;
          if (list.isEmpty) {
            return const Center(child: Text("No history found"));
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.savings),
                title: Text("₹${list[index]}"),
              );
            },
          );
        },
      ),
    );
  }
}
