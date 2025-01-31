import 'package:expense_tracker_bloc/domain/entities/expense.dart';
import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  String amount;

  @HiveField(1)
  String descrip;

  @HiveField(2)
  String date;

  @HiveField(3)
  String category;

  ExpenseModel(
      {required this.amount,
      required this.category,
      required this.descrip,
      required this.date});
}

@HiveType(typeId: 1)
enum ExpenseCategory {
  @HiveField(0)
  food('Food & Dining', 'Food expenses including restaurants and dining out'),

  @HiveField(1)
  transportation(
      'Transportation', 'Fuel, public transport, vehicle maintenance'),

  @HiveField(2)
  shopping('Shopping', 'Clothing, accessories, and general shopping'),

  @HiveField(3)
  utilities('Bills & Utilities', 'Electricity, water, internet, phone bills'),

  @HiveField(4)
  healthcare(
      'Healthcare', 'Medical expenses, medicines, and healthcare services'),

  @HiveField(5)
  entertainment('Entertainment', 'Movies, games, streaming services'),

  @HiveField(6)
  education('Education', 'Tuition, books, courses'),

  @HiveField(7)
  groceries('Groceries', 'Supermarket purchases and household items'),

  @HiveField(8)
  rent('Rent & Housing', 'Rent, mortgage, maintenance'),

  @HiveField(9)
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
}

extension ExpenseModelMapper on ExpenseModel {
  Expense toEntity() {
    return Expense(
      key: key,
      amount: amount,
      description: descrip,
      date: date,
      category: category,
    );
  }
}

extension ExpenseMapper on Expense {
  ExpenseModel toModel() {
    return ExpenseModel(
      amount: amount,
      descrip: description,
      date: date,
      category: category,
    );
  }
}
