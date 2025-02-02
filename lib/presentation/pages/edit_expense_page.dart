import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/expense.dart';
import '../bloc/home/home_bloc.dart';

class EditExpensePage extends StatefulWidget {
  final Expense expense;

  const EditExpensePage({super.key, required this.expense});

  @override
  _EditExpensePageState createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory =
      ExpenseCategory.food.displayName; // Default category

  @override
  void initState() {
    super.initState();
    amountController.text = widget.expense.amount;
    descriptionController.text = widget.expense.description;
    selectedCategory = widget.expense.category; // Set the selected category
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _updateExpense() {
    final dynamic keyToBeUpdate = widget.expense.key;

    final updatedExpense = Expense(
      amount: amountController.text,
      description: descriptionController.text,
      date: widget.expense.date,
      category: selectedCategory,
    );

    context
        .read<HomeBloc>()
        .add(HomeUpdateExpenseEvent(keyToBeUpdate, updatedExpense));
    Navigator.pop(context); // Go back after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Expense', style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: ExpenseCategory.values.map((ExpenseCategory category) {
                return DropdownMenuItem<String>(
                  value: category.displayName,
                  child: Text(category.displayName),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateExpense,
              child: const Text('Update Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
