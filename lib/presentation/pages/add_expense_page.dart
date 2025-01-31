import 'package:expense_tracker_bloc/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../../core/utils/category_utils.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  ExpenseCategory selectedCategory = ExpenseCategory.other;

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _addExpense() {
    final amount = amountController.text;
    final description = descriptionController.text;
    final date = DateTime.now()
        .toString(); // Use current date or implement a date picker

    final expense = Expense(
      // Generate a unique ID
      amount: amount,
      description: description,
      date: date,
      category: selectedCategory.displayName, // Use displayName for storage
    );

    context
        .read<HomeBloc>()
        .add(HomeAddExpenseEvent(expense)); // Add the expense
    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Expense',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Selection
            Text(
              'Category',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            DropdownButton<ExpenseCategory>(
              value: selectedCategory,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: ExpenseCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Row(
                    children: [
                      Icon(
                        CategoryUtils.getIconForCategory(category),
                        color: CategoryUtils.getColorForCategory(category),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        category.displayName,
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (newCategory) {
                if (newCategory != null) {
                  setState(() {
                    selectedCategory = newCategory;
                  });
                }
              },
            ),

            const SizedBox(height: 24),

            // Amount Input
            Text(
              'Amount',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: CategoryUtils.getColorForCategory(selectedCategory),
                ),
                hintText: '0.00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Description Input
            Text(
              'Description',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.description_outlined,
                  color: CategoryUtils.getColorForCategory(selectedCategory),
                ),
                hintText: 'Add description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _addExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      CategoryUtils.getColorForCategory(selectedCategory),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Expense',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
