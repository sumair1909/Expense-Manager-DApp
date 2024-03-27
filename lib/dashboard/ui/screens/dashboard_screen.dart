import 'package:expense_manager/dashboard/ui/widgets/account_details_card.dart';
import 'package:expense_manager/dashboard/ui/widgets/outlined_button.dart';
import 'package:expense_manager/dashboard/ui/widgets/transaction_card.dart';
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
            const AccountDetailsCard(balance: "50", userName: "SUMAIR BAIS"),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOutlinedButton(
                  buttonText: "Debit",
                  onTap: () {},
                ),
                SizedBox(width: 30.w),
                CustomOutlinedButton(
                  buttonText: "Credit",
                  onTap: () {},
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, bottom: 10.h, top: 10.h),
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
