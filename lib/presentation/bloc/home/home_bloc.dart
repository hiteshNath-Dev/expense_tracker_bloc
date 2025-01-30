import 'package:expense_tracker_bloc/presentation/bloc/home/home_event.dart';
import 'package:expense_tracker_bloc/presentation/bloc/home/home_state.dart';
import 'package:expense_tracker_bloc/data/data_sources/local/hive_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HiveHelper helper;

  HomeBloc(this.helper) : super(HomeInitial()) {
    // Load Expenses
    on<HomeLoadedEvent>((event, emit) {
      _loadExpenses(emit);
    });

    // Delete Expense
    on<HomeDeleteEvent>((event, emit) {
      helper.deleteExpense(event.key); // Delete from Hive
      _loadExpenses(emit); // Reload and update state
    });
  }

  // Helper function to load expenses
  void _loadExpenses(Emitter<HomeState> emit) {
    final expenses = helper.getAllExpenses().reversed.toList();

    // Calculate totals
    double totalIncome = 0.0;
    double totalExpense = 0.0;
    double totalBalance = 0.0;

    for (var expense in expenses) {
      if (expense.amountType == 'TransactionType.income') {
        totalBalance += double.parse(expense.amount);
        totalIncome += double.parse(expense.amount);
      } else if (expense.amountType == 'TransactionType.expense') {
        totalBalance -= double.parse(expense.amount);
        totalExpense += double.parse(expense.amount);
      }
    }

    emit(HomeLoadedState(expenses, totalBalance, totalIncome, totalExpense));
  }
}
