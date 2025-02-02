import 'package:expense_tracker_bloc/domain/entities/expense.dart';
import 'package:expense_tracker_bloc/presentation/pages/edit_expense_page.dart';
import 'package:expense_tracker_bloc/presentation/widgets/expense_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/category_utils.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/utils.dart';
import '../bloc/home/home_bloc.dart';
import 'add_expense_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoadedState) {
            return Column(
              children: [
                // Pie Chart for Expenses
                Padding(
                  padding: const EdgeInsets.all(16.0),

                  child: ExpensePieChart(
                      expenses: state.expenseList), // Pass the expenses
                ),

                // Recent Expenses
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Recent Expenses',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Expenses List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.expenseList.length,
                    itemBuilder: (context, index) {
                      final expense = state.expenseList[index];

                      return Dismissible(
                        key: ValueKey(expense.key),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red.shade700,
                          ),
                        ),
                        onDismissed: (direction) {
                          context.read<HomeBloc>().add(
                                HomeDeleteEvent(expense.key),
                              );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditExpensePage(
                                    expense: expense), // Navigate to edit page
                              ),
                            );
                          },
                          child: Card(
                            elevation: 0,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: CategoryUtils.getColorForCategory(
                                    ExpenseCategory.fromString(
                                        expense.category),
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  CategoryUtils.getIconForCategory(
                                    ExpenseCategory.fromString(
                                        expense.category),
                                  ),
                                  color: CategoryUtils.getColorForCategory(
                                    ExpenseCategory.fromString(
                                        expense.category),
                                  ),
                                ),
                              ),
                              title: Text(
                                expense.description,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                Utils.dateFormated(expense.date),
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Text(
                                '\$${expense.amount}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: CategoryUtils.getColorForCategory(
                                    ExpenseCategory.fromString(
                                        expense.category),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is HomeErrorState) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('No expenses found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpensePage(),
            ),
          );
        },
        backgroundColor: AppColor.blackColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Expense',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
