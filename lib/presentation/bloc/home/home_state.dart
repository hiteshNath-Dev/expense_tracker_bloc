part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Expense> expenseList;
  final double totalExpense;

  HomeLoadedState({
    required this.expenseList,
    required this.totalExpense,
  });
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}
