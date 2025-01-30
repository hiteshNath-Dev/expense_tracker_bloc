part of 'ammount_bloc.dart';

abstract class AmmountEvent extends Equatable {
  const AmmountEvent();

  @override
  List<Object> get props => [];
}

class AmmountAddEvent extends AmmountEvent {
  final String ammount;
  final String ammountType;
  final String descrip;
  final String date;

  const AmmountAddEvent(
      {required this.ammount,
      required this.ammountType,
      required this.descrip,
      required this.date});

  @override
  List<Object> get props => [ammount, ammountType, descrip, date];
}
