import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';
import '../models/savings_goal.dart';

class ApiService {
  static const String baseUrl = "http://localhost:8080/api";


  // ADD EXPENSE
  static Future<void> addExpense(
      double amount, String category, String description) async {
    final response = await http.post(
      Uri.parse('$baseUrl/expenses'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "amount": amount,
        "category": category,
        "description": description
      }),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add expense");
    }
  }

  // TODAY TOTAL
  static Future<double> getTodayTotal() async {
    final response =
        await http.get(Uri.parse('$baseUrl/expenses/total/today'));
    return double.parse(response.body);
  }

  // GET CURRENT MONTH TOTAL
static Future<double> getMonthTotal() async {
  final response =
      await http.get(Uri.parse('$baseUrl/expenses/total/month'));

  if (response.statusCode == 200) {
    return double.parse(response.body);
  } else {
    throw Exception("Failed to load monthly total");
  }
}


// CREATE SAVINGS GOAL
static Future<void> createSavingsGoal(
    String title, double targetAmount) async {

  final response = await http.post(
    Uri.parse('$baseUrl/savings'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "title": title,
      "targetAmount": targetAmount, // ✅ MUST be camelCase
      "saved": 0
    }),
  );

  if (response.statusCode != 201) {
    throw Exception("Failed to create savings goal");
  }
}

// Get Savings Goals
static Future<List<SavingsGoal>> getAllSavingsGoals() async {
  final response =
      await http.get(Uri.parse('$baseUrl/savings/all'));

  final List data = jsonDecode(response.body);
  return data.map((e) => SavingsGoal.fromJson(e)).toList();
}


  // ALL EXPENSES
  static Future<List<Expense>> getExpenses() async {
  final response = await http.get(Uri.parse('$baseUrl/expenses'));

  if (response.statusCode != 200) {
    throw Exception("Failed to load expenses");
  }

  final List<dynamic> data = jsonDecode(response.body);

  return data
      .map((e) => Expense.fromJson(e as Map<String, dynamic>))
      .toList();
}
//ADD Saving amount
static Future<void> addSavedAmount(
    int goalId, double amount) async {

  final response = await http.put(
    Uri.parse('$baseUrl/savings/$goalId/save/$amount'),
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to add saved amount");
  }
}

static Future<List<double>> getSavingsHistory(int goalId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/savings/$goalId/history'),
  );

  final List<dynamic> data = jsonDecode(response.body);
  return data.map((e) => (e as num).toDouble()).toList();
}

  // SAVINGS GOAL
  static Future<SavingsGoal?> getSavingsGoal() async {
    final response = await http.get(Uri.parse('$baseUrl/savings'));
    if (response.statusCode == 204) return null;
    return SavingsGoal.fromJson(jsonDecode(response.body));
  }

  // SAVINGS PROGRESS
  static Future<double> getSavingsProgress() async {
    final response =
        await http.get(Uri.parse('$baseUrl/savings/progress'));
    return double.parse(response.body);
  }

  // ADD SAVINGS
  static Future<void> addSavingsAmount(double amount) async {
    final response =
        await http.put(Uri.parse('$baseUrl/savings/add/$amount'));
    if (response.statusCode != 200) {
      throw Exception("Failed to add savings");
    }
  }
}
