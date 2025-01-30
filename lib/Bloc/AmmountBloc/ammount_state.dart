part of 'ammount_bloc.dart';

abstract class AmmountState extends Equatable {
  const AmmountState();

  @override
  List<Object> get props => [];
}

class AmmountInitial extends AmmountState {}

class AmmountValidateState extends AmmountState {}

class AmmountAddedSuccessState extends AmmountState {
  final String successmsg;

  const AmmountAddedSuccessState({required this.successmsg});
  @override
  List<Object> get props => [];
}

class AmmountAddedErrorState extends AmmountState {
  final String errormsg;

  const AmmountAddedErrorState({required this.errormsg});
  @override
  List<Object> get props => [errormsg];
}
