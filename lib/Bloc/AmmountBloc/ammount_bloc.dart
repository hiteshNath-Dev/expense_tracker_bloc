import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker_bloc/services/HiveHelper/HiveHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'ammount_event.dart';
part 'ammount_state.dart';

class AmmountBloc extends Bloc<AmmountEvent, AmmountState> {
  final HiveHelper helper;
  final BuildContext context;
  AmmountBloc(this.helper, this.context) : super(AmmountInitial()) {
    on<AmmountAddEvent>((event, emit) async {
      try {
        if (event.ammount.isEmpty) {
          emit(const AmmountAddedErrorState(
              errormsg: 'Please Enter the ammount'));
          if (kDebugMode) {
            print('enter the data');
          }
        } else if (event.descrip.isEmpty) {
          emit(const AmmountAddedErrorState(
              errormsg: 'Please Enter the Description'));
        } else {
          emit(AmmountValidateState());
          await helper
              .addAmmount(
                  event.ammount, event.ammountType, event.descrip, event.date)
              .then((value) =>
                  emit(const AmmountAddedSuccessState(successmsg: 'Success')));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        emit(AmmountAddedErrorState(errormsg: e.toString()));
      }
    });
  }
}
