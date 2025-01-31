import 'package:expense_tracker_bloc/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class CategoryUtils {
  static IconData getIconForCategory(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Icons.restaurant;
      case ExpenseCategory.transportation:
        return Icons.directions_car;
      case ExpenseCategory.shopping:
        return Icons.shopping_bag;
      case ExpenseCategory.utilities:
        return Icons.receipt_long;
      case ExpenseCategory.healthcare:
        return Icons.medical_services;
      case ExpenseCategory.entertainment:
        return Icons.movie;
      case ExpenseCategory.education:
        return Icons.school;
      case ExpenseCategory.groceries:
        return Icons.shopping_cart;
      case ExpenseCategory.rent:
        return Icons.home;
      case ExpenseCategory.other:
        return Icons.more_horiz;
    }
  }

  static Color getColorForCategory(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Colors.orange;
      case ExpenseCategory.transportation:
        return Colors.blue;
      case ExpenseCategory.shopping:
        return Colors.purple;
      case ExpenseCategory.utilities:
        return Colors.green;
      case ExpenseCategory.healthcare:
        return Colors.red;
      case ExpenseCategory.entertainment:
        return Colors.pink;
      case ExpenseCategory.education:
        return Colors.brown;
      case ExpenseCategory.groceries:
        return Colors.teal;
      case ExpenseCategory.rent:
        return Colors.indigo;
      case ExpenseCategory.other:
        return Colors.grey;
    }
  }
}
