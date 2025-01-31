import 'dart:developer';

import 'package:expense_tracker_bloc/domain/entities/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/expense_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ExpenseRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeLoadedEvent>((event, emit) async {
      emit(HomeInitial()); // Emit initial state before loading
      final result = await repository.getExpenses(); // Get expenses

      await result.fold(
        (failure) async =>
            emit(HomeErrorState(failure.message)), // Handle failure
        (expenses) async {
          // log("expenses--->${expenses.first.key}");

          final totalExpenseResult = await repository.getTotalExpense();
          await totalExpenseResult.fold(
            (failure) async =>
                emit(HomeErrorState(failure.message)), // Handle failure
            (totalExpense) async {
              emit(HomeLoadedState(
                expenseList: expenses,
                totalExpense: totalExpense,
              ));
            },
          );
        },
      );
    });

    on<HomeDeleteEvent>((event, emit) async {
      final deleteResult = await repository.deleteExpense(event.key);
      log("key--->${event.key}");
      await deleteResult.fold(
        (failure) async =>
            emit(HomeErrorState(failure.message)), // Handle failure
        (_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          add(HomeLoadedEvent()); // Reload the list after deletion
        },
      );
    });

    on<HomeAddExpenseEvent>((event, emit) async {
      final addResult = await repository.addExpense(event.expense);
      await addResult.fold(
        (failure) async => emit(HomeErrorState(failure.message)),
        (_) async {
          add(HomeLoadedEvent()); // Reload the list after adding
        },
      );
    });
  }
}
