import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddSavedAmountScreen extends StatefulWidget {
  final int goalId;

  const AddSavedAmountScreen({super.key, required this.goalId});

  @override
  State<AddSavedAmountScreen> createState() => _AddSavedAmountScreenState();
}

class _AddSavedAmountScreenState extends State<AddSavedAmountScreen> {
  final amountCtrl = TextEditingController();

  void saveAmount() async {
    if (amountCtrl.text.isEmpty) return;

    await ApiService.addSavedAmount(
      widget.goalId,
      double.parse(amountCtrl.text),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Saving Amount")),
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
                    controller: amountCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Amount (₹)",
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveAmount,
                    child: const Text("Save Amount"),
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
