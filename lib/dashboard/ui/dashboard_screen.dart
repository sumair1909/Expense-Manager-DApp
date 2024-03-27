import 'package:expense_manager/utils/asset_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "BitBank",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
              child: Text(
                'Transactions',
                style: GoogleFonts.spaceGrotesk(
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) => const TransactionCard(
                  reason: "Salary",
                  amount: "50 ETH",
                  date: "12/12/2021",
                ),
              ),
            )
          ],
        ));
  }
}

class TransactionCard extends StatelessWidget {
  final String reason;
  final String amount;
  final String date;
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
                date,
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
            amount,
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
