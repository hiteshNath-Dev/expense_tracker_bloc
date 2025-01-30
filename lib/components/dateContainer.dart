// ignore_for_file: must_be_immutable

import 'package:expense_tracker_bloc/utils/Color/AppColors.dart';
import 'package:expense_tracker_bloc/utils/extenshion/extenshion.dart';
import 'package:expense_tracker_bloc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateContainer extends StatelessWidget {
  String date;
  DateContainer({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mh * 0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.blackColor)),
      child: Center(
        child: Text(Utils.dateFormated(date),
            style:
                GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
