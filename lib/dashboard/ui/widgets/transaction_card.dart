import 'package:expense_manager/utils/asset_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionCard extends StatelessWidget {
  final String reason;
  final String amount;
  final DateTime date;
  const TransactionCard(
      {super.key,
      required this.reason,
      required this.amount,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(minHeight: 65.h),
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ]),
      child: Row(
        children: [
          Image.asset(
            AssetStrings.ethLogo,
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reason,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                )),
              ),
              Text(
                date.toString(),
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                )),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "$amount ETH",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            )),
          ),
        ],
      ),
    );
  }
}
