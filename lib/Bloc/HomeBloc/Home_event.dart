import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  //implement props
  List<Object?> get props => [];
}

class HomeLoadedEvent extends HomeEvent {
  HomeLoadedEvent();

  @override
  //implement props
  List<Object?> get props => [];
}

class HomeDeleteEvent extends HomeEvent {
  final int key; // Or ExpenseModel expense;

  HomeDeleteEvent(this.key);
}
