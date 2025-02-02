part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeLoadedEvent extends HomeEvent {}

class HomeDeleteEvent extends HomeEvent {
  final dynamic key;
  HomeDeleteEvent(this.key);
}

class HomeAddExpenseEvent extends HomeEvent {
  final Expense expense;

  HomeAddExpenseEvent(this.expense);
}

class HomeUpdateExpenseEvent extends HomeEvent {
  final dynamic key;
  final Expense expense;

  HomeUpdateExpenseEvent(this.key, this.expense);
}
