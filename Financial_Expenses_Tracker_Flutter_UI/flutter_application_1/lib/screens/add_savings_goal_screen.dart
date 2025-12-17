import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddSavingsGoalScreen extends StatefulWidget {
  const AddSavingsGoalScreen({super.key});

  @override
  State<AddSavingsGoalScreen> createState() => _AddSavingsGoalScreenState();
}

class _AddSavingsGoalScreenState extends State<AddSavingsGoalScreen> {
  final nameCtrl = TextEditingController();
  final targetCtrl = TextEditingController();

  void saveGoal() async {
  if (nameCtrl.text.isEmpty || targetCtrl.text.isEmpty) return;

  await ApiService.createSavingsGoal(
    nameCtrl.text,
    double.parse(targetCtrl.text),
  );

  Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Savings Goal")),
      body: Center(
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration:
                        const InputDecoration(labelText: "Goal Name"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: targetCtrl,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: "Target Amount (₹)"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveGoal,
                    child: const Text("Save Goal"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
