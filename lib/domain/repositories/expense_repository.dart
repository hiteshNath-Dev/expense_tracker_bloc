import 'package:dartz/dartz.dart';
import '../entities/expense.dart';
import '../../core/error/failures.dart';

abstract class ExpenseRepository {
  /// Get all expenses
  Future<Either<Failure, List<Expense>>> getExpenses();

  /// Add a new expense
  Future<Either<Failure, void>> addExpense(Expense expense);

  /// Delete an expense by its key
  Future<Either<Failure, void>> deleteExpense(dynamic key);

  /// Get total expenses amount
  Future<Either<Failure, double>> getTotalExpense();

  /// Get expenses by category
  Future<Either<Failure, List<Expense>>> getExpensesByCategory(String category);

  /// Get expenses by date range
  Future<Either<Failure, List<Expense>>> getExpensesByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Update an expense
  Future<Either<Failure, void>> updateExpense(String id, Expense expense);

  /// Get expenses for current month
  Future<Either<Failure, List<Expense>>> getCurrentMonthExpenses();
}
