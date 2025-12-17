import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final amountCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  String category = "Food";

  final categories = ["Food", "Travel", "Shopping", "Bills", "Others"];

  void saveExpense() async {
    if (amountCtrl.text.isEmpty) return;

    await ApiService.addExpense(
      double.parse(amountCtrl.text),
      category,
      descCtrl.text,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Center(
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Amount (₹)",
                      prefixIcon: Icon(Icons.currency_rupee),
                    ),
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    value: category,
                    items: categories
                        .map((c) =>
                            DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (val) => setState(() => category = val!),
                    decoration:
                        const InputDecoration(labelText: "Category"),
                  ),

                  const SizedBox(height: 10),
                  TextField(
                    controller: descCtrl,
                    decoration:
                        const InputDecoration(labelText: "Description"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: saveExpense,
                      child: const Text("Save Expense")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
