import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:expense_tracker_bloc/data/data_sources/local/hive_helper.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../domain/entities/expense.dart';
import '../../core/error/failures.dart';
import 'package:expense_tracker_bloc/data/models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final HiveHelper _hiveHelper;

  ExpenseRepositoryImpl(this._hiveHelper);

  @override
  Future<Either<Failure, List<Expense>>> getExpenses() async {
    try {
      log("Repository imp --->");

      final models = await _hiveHelper.getAllExpenses();
      log("Hive result --->${models.length}");

      final expenses = models.map((model) => model.toEntity()).toList();
      return Right(expenses);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addExpense(Expense expense) async {
    try {
      log("Repository imp --->$expense");
      final model = expense.toModel();
      log("After modeling --->$model");

      await _hiveHelper.addExpense(model);
      log("After hive --->");

      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(dynamic key) async {
    try {
      await _hiveHelper.deleteExpense(key);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalExpense() async {
    try {
      final result = await getExpenses();
      return result.fold(
        (failure) => Left(failure),
        (expenses) {
          final total = expenses.fold<double>(
            0.0,
            (sum, expense) => sum + double.parse(expense.amount),
          );
          return Right(total);
        },
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getExpensesByCategory(
    String category,
  ) async {
    try {
      final result = await getExpenses();
      return result.fold(
        (failure) => Left(failure),
        (expenses) {
          final filtered = expenses
              .where((expense) => expense.category == category)
              .toList();
          return Right(filtered);
        },
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getExpensesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final result = await getExpenses();
      return result.fold(
        (failure) => Left(failure),
        (expenses) {
          final filtered = expenses.where((expense) {
            final expenseDate = DateTime.parse(expense.date);
            return expenseDate
                    .isAfter(startDate.subtract(const Duration(days: 1))) &&
                expenseDate.isBefore(endDate.add(const Duration(days: 1)));
          }).toList();
          return Right(filtered);
        },
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateExpense(
      String id, Expense expense) async {
    try {
      final model = expense.toModel();
      await _hiveHelper.updateExpense(id, model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getCurrentMonthExpenses() async {
    try {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      return getExpensesByDateRange(startOfMonth, endOfMonth);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
