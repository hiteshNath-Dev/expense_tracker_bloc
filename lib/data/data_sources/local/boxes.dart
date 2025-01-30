import 'package:expense_tracker_bloc/data/models/expense_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<ExpenseModel> getData() => Hive.box<ExpenseModel>('ExpenseBox');
}
