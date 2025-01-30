// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker_bloc/presentation/bloc/amount/amount_bloc.dart';
import 'package:expense_tracker_bloc/presentation/bloc/home/home_bloc.dart';
import 'package:expense_tracker_bloc/presentation/bloc/home/home_event.dart';
import 'package:expense_tracker_bloc/presentation/bloc/date/date_cubit.dart';
import 'package:expense_tracker_bloc/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:expense_tracker_bloc/presentation/widgets/textFrom_feilds.dart';
import 'package:expense_tracker_bloc/presentation/widgets/date_container.dart';
import 'package:expense_tracker_bloc/presentation/widgets/resuable_container.dart';
import 'package:expense_tracker_bloc/presentation/widgets/reuseable_btn.dart';
import 'package:expense_tracker_bloc/core/constants/app_colors.dart';
import 'package:expense_tracker_bloc/core/utils/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class addAmount extends StatefulWidget {
  const addAmount({super.key});

  @override
  State<addAmount> createState() => _addAmountState();
}

class _addAmountState extends State<addAmount> {
  TextEditingController amountController = TextEditingController();
  TextEditingController dscripController = TextEditingController();

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    amountController.dispose();
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
                        BlocBuilder<AmountBloc, AmountState>(
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
                                      label: 'Amount',
                                      type: TextInputType.number,
                                      controller: amountController,
                                    ))
                                  ],
                                ),
                                state is AmountAddedErrorState &&
                                        state.errormsg ==
                                            "Please Enter the amount"
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
                                state is AmountAddedErrorState &&
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
                                    context.read<AmountBloc>().add(
                                        AmountAddEvent(
                                            amount: amountController.text,
                                            amountType: type.toString(),
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
