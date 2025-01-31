import 'dart:developer';

import 'package:hive/hive.dart';
import '../../models/expense_model.dart';

class HiveHelper {
  static const String expenseBoxName = 'ExpenseBox';

  Box<ExpenseModel> getExpenseBox() => Hive.box<ExpenseModel>(expenseBoxName);

  Future<List<ExpenseModel>> getAllExpenses() async {
    final box = getExpenseBox();
    return box.values.toList();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    final box = getExpenseBox();
    await box.add(expense);
    log("after adding from hive");
  }

  Future<void> deleteExpense(dynamic key) async {
    final box = getExpenseBox();
    if (box.containsKey(key)) {
      await box.delete(key);
    } else {
      log("Key not found in Hive: $key");
    }
    // await box.delete(key);
  }

  Future<void> updateExpense(dynamic key, ExpenseModel expense) async {
    final box = getExpenseBox();
    await box.put(key, expense);
  }
}
