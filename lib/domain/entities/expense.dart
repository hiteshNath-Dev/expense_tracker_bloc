import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Expense extends Equatable {
  final dynamic key;
  final String amount;
  final String description;
  final String date;
  final String category;

  const Expense({
    this.key,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
  });

  @override
  List<Object?> get props => [key, amount, description, date, category];
}

// We keep the enum here because it's business logic
enum ExpenseCategory {
  food('Food & Dining', 'Food expenses including restaurants and dining out'),
  transportation(
      'Transportation', 'Fuel, public transport, vehicle maintenance'),
  shopping('Shopping', 'Clothing, accessories, and general shopping'),
  utilities('Bills & Utilities', 'Electricity, water, internet, phone bills'),
  healthcare(
      'Healthcare', 'Medical expenses, medicines, and healthcare services'),
  entertainment('Entertainment', 'Movies, games, streaming services'),
  education('Education', 'Tuition, books, courses'),
  groceries('Groceries', 'Supermarket purchases and household items'),
  rent('Rent & Housing', 'Rent, mortgage, maintenance'),
  other('Other', 'Miscellaneous expenses');

  final String displayName;
  final String description;

  const ExpenseCategory(this.displayName, this.description);

  static ExpenseCategory fromString(String name) {
    return ExpenseCategory.values.firstWhere(
      (category) => category.displayName.toLowerCase() == name.toLowerCase(),
      orElse: () => ExpenseCategory.other, // Default case
    );
  }

  // Helper methods for UI
  IconData get icon {
    switch (this) {
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

  Color get color {
    switch (this) {
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
