import 'package:expense_tracker_bloc/components/expenseComp.dart';
import 'package:expense_tracker_bloc/components/incomeComp.dart';

import 'package:expense_tracker_bloc/utils/Color/AppColors.dart';
import 'package:expense_tracker_bloc/utils/extenshion/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalBalanceComp extends StatelessWidget {
  final String value;
  final String Incnomevalue;
  final String Expensevalue;
  const TotalBalanceComp(
      {super.key,
      required this.value,
      required this.Incnomevalue,
      required this.Expensevalue});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: context.mw * 0.03, vertical: context.mh * 0.02),
        height: context.mh * 0.25,
        width: context.mw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [
              AppColor.blackColor,
              AppColor.blueColor,
            ], begin: Alignment.center, end: Alignment.topLeft)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total Balance',
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: AppColor.whiteColor),
              ),
              0.02.ph(context),
              Text(
                '$value Rs',
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteColor),
              ),
              0.03.ph(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IncomeComp(value: Incnomevalue),
                  ExpenseComp(value: Expensevalue)
                ],
              )
            ]));
  }
}
