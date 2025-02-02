import 'package:expense_tracker_bloc/core/utils/category_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/expense.dart';

class ExpensePieChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensePieChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Calculate total expenses
    double total =
        expenses.fold(0, (sum, item) => sum + double.parse(item.amount));

    // Group expenses by category
    Map<ExpenseCategory, double> categoryTotals = {};
    for (var expense in expenses) {
      var category = ExpenseCategory.fromString(expense.category);
      categoryTotals[category] =
          (categoryTotals[category] ?? 0) + double.parse(expense.amount);
    }

    // Prepare data for the pie chart
    List<PieChartSectionData> sections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        color: CategoryUtils.getColorForCategory(entry.key),
        value: entry.value,
        title: '${(entry.value / total * 100).toStringAsFixed(1)}%',
        radius: 50,
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        borderData: FlBorderData(show: false),
        centerSpaceRadius: 40,
        sectionsSpace: 0,
      ),
    );
  }
}
