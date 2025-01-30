// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker_bloc/Bloc/AmmountBloc/ammount_bloc.dart';
import 'package:expense_tracker_bloc/Bloc/HomeBloc/Home_bloc.dart';
import 'package:expense_tracker_bloc/Bloc/HomeBloc/Home_event.dart';
import 'package:expense_tracker_bloc/Bloc/cubit/setDateCubit.dart';
import 'package:expense_tracker_bloc/Bloc/cubit/transactionCubit.dart';
import 'package:expense_tracker_bloc/components/TextFromFeilds.dart';
import 'package:expense_tracker_bloc/components/dateContainer.dart';
import 'package:expense_tracker_bloc/components/resuableContainer.dart';
import 'package:expense_tracker_bloc/components/reuseableBtn.dart';
import 'package:expense_tracker_bloc/utils/Color/AppColors.dart';
import 'package:expense_tracker_bloc/utils/extenshion/extenshion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAmmount extends StatefulWidget {
  const AddAmmount({super.key});

  @override
  State<AddAmmount> createState() => _AddAmmountState();
}

class _AddAmmountState extends State<AddAmmount> {
  TextEditingController ammountController = TextEditingController();
  TextEditingController dscripController = TextEditingController();

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    ammountController.dispose();
    dscripController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Print');
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: Text(
            'Add Amount',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              0.05.ph(context),
              BlocBuilder<TransactionCubit, TransactionType>(
                builder: (context, type) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                    child: Column(
                      children: [
                        BlocBuilder<AmmountBloc, AmmountState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    ReuseAbleContainer(
                                        icon: FontAwesomeIcons.dollarSign),
                                    0.04.pw(context),
                                    Expanded(
                                        child: ReuseableFeilds(
                                      hint: '0',
                                      label: 'Ammount',
                                      type: TextInputType.number,
                                      controller: ammountController,
                                    ))
                                  ],
                                ),
                                state is AmmountAddedErrorState &&
                                        state.errormsg ==
                                            "Please Enter the ammount"
                                    ? Text(
                                        state.errormsg,
                                        style: GoogleFonts.poppins(
                                            color: Colors.red),
                                      )
                                    : Container(),
                                0.03.ph(context),
                                Row(
                                  children: [
                                    ReuseAbleContainer(
                                        icon: Icons.details_outlined),
                                    0.04.pw(context),
                                    Expanded(
                                        child: ReuseableFeilds(
                                      hint: '',
                                      label: 'Description',
                                      type: TextInputType.text,
                                      controller: dscripController,
                                    ))
                                  ],
                                ),
                                state is AmmountAddedErrorState &&
                                        state.errormsg ==
                                            "Please Enter the Description"
                                    ? Text(
                                        state.errormsg,
                                        style: GoogleFonts.poppins(
                                            color: Colors.red),
                                      )
                                    : Container(),
                              ],
                            );
                          },
                        ),
                        0.03.ph(context),
                        Row(
                          children: [
                            ReuseAbleContainer(icon: Icons.moving_sharp),
                            0.04.pw(context),
                            Row(
                              children: [
                                ChoiceChip(
                                    selectedColor: AppColor.blackColor,
                                    label: Text(
                                      'Expense',
                                      style: GoogleFonts.poppins(
                                          color: type == TransactionType.expense
                                              ? AppColor.whiteColor
                                              : AppColor.blackColor),
                                    ),
                                    onSelected: (value) {
                                      context
                                          .read<TransactionCubit>()
                                          .setType(TransactionType.expense);
                                    },
                                    selected: type == TransactionType.expense
                                        ? true
                                        : false),
                                0.04.pw(context),
                                ChoiceChip(
                                    selectedColor: AppColor.blackColor,
                                    label: Text(
                                      'Income',
                                      style: GoogleFonts.poppins(
                                          color: type == TransactionType.income
                                              ? AppColor.whiteColor
                                              : AppColor.blackColor),
                                    ),
                                    onSelected: (value) {
                                      context
                                          .read<TransactionCubit>()
                                          .setType(TransactionType.income);
                                    },
                                    selected: type == TransactionType.income
                                        ? true
                                        : false),
                              ],
                            )
                          ],
                        ),
                        0.03.ph(context),
                        BlocBuilder<DateCubit, DateTime>(
                          builder: (context, selectedDate) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final newDate = await showDatePicker(
                                          context: context,
                                          initialDate: selectedDate,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );
                                        if (newDate != null) {
                                          context
                                              .read<DateCubit>()
                                              .setDate(newDate);
                                        }
                                      },
                                      child: ReuseAbleContainer(
                                          icon: Icons.date_range),
                                    ),
                                    0.04.pw(context),
                                    Expanded(
                                        child: DateContainer(
                                            date: selectedDate
                                                .toLocal()
                                                .toString()))
                                  ],
                                ),
                                0.04.ph(context),
                                ReuseAbleBtn(
                                  ontap: () {
                                    context.read<AmmountBloc>().add(
                                        AmmountAddEvent(
                                            ammount: ammountController.text,
                                            ammountType: type.toString(),
                                            descrip: dscripController.text,
                                            date: selectedDate.toString()));

                                    context
                                        .read<HomeBloc>()
                                        .add(HomeLoadedEvent());

                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
