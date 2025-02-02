import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/expense.dart';
import '../../core/utils/category_utils.dart';

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

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 200, // Set a fixed height for the pie chart
          child: PieChart(
            PieChartData(
              sections: sections,
              borderData: FlBorderData(show: false),
              centerSpaceRadius: 40,
              sectionsSpace: 0,
            ),
          ),
        ),
        // Center widget to display total expense
        Positioned(
          child: Text(
            '\$${total.toStringAsFixed(2)}', // Display total expense
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(
      Map<ExpenseCategory, double> categoryTotals, double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categoryTotals.entries.map((entry) {
        final percentage = (entry.value / total * 100).toStringAsFixed(1);
        return Row(
          children: [
            Container(
              width: 16,
              height: 16,
              color: CategoryUtils.getColorForCategory(entry.key),
            ),
            const SizedBox(width: 8),
            Text(
              '${entry.key.displayName}: $percentage%',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        );
      }).toList(),
    );
  }
}
