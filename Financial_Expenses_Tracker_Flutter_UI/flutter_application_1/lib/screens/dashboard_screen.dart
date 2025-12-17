import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'add_expense_screen.dart';
import 'expense_list_screen.dart';
import 'savings_goal_screen.dart';
import 'add_savings_goal_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double todayTotal = 0;
  double monthTotal = 0;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  void loadDashboard() async {
    todayTotal = await ApiService.getTodayTotal();
    monthTotal = await ApiService.getMonthTotal();
    setState(() {});
  }

  Widget infoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(value,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add Expense",
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AddExpenseScreen()),
              );
              loadDashboard();
            },
          ),
          IconButton(
  icon: const Icon(Icons.savings),
  tooltip: "Add Savings Goal",
  onPressed: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => const AddSavingsGoalScreen()),
    );
  },
),
IconButton(
  icon: const Icon(Icons.savings),
  tooltip: "Savings Goals",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SavingsGoalsListScreen(),
      ),
    );
  },
),

        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            infoCard("Today Spent", "₹$todayTotal", Icons.today),
            infoCard("This Month", "₹$monthTotal", Icons.calendar_month),

            const SizedBox(height: 20),

            // SAVINGS CARD
            Card(
              elevation: 6,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.savings),
                title: const Text("Savings Goals"),
                subtitle: const Text("View your savings progress"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (_) => const SavingsGoalsListScreen()),
  );
},

              ),
            ),

            const SizedBox(height: 20),

            // EXPENSE HISTORY
            Card(
              elevation: 6,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Expense History"),
                subtitle: const Text("View all expenses"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ExpenseListScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
