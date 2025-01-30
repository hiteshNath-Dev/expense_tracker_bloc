import 'package:expense_tracker_bloc/Models/expenseModel.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<ExpenseModel> getData() => Hive.box<ExpenseModel>('ExpenseBox');
}
