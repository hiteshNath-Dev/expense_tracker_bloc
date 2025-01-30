import 'package:expense_tracker_bloc/data/models/expense_model.dart';
import 'package:expense_tracker_bloc/data/data_sources/local/boxes.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  late Box<ExpenseModel> _expenseBox;
  // Constructor to initialize the Hive box
  HiveHelper() {
    _initHive();
  }

  // Initialize the Hive box
  void _initHive() async {
    _expenseBox = Boxes.getData();
  }

  Future<void> addAmount(var amount, amountType, descrip, date) async {
    try {
      final data = ExpenseModel(
          amount: amount, amountType: amountType, descrip: descrip, date: date);
      if (kDebugMode) {
        print(data.amount.toString());
      }
      final box = Boxes.getData();
      box.add(data);
      data.save();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // **Delete Expense by Key**
  Future<void> deleteExpense(int key) async {
    try {
      final box = Boxes.getData();
      await box.delete(key); // Delete by key
      if (kDebugMode) {
        print("Expense deleted at key: $key");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting expense: ${e.toString()}");
      }
    }
  }

  // get data from the Hive database
  List<ExpenseModel> getAllExpenses() {
    return _expenseBox.values.toList();
  }
}
