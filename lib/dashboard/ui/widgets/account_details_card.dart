import 'package:expense_manager/utils/asset_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountDetailsCard extends StatelessWidget {
  final String balance;
  final String userName;
  final String? walletAddress;
  const AccountDetailsCard(
      {super.key,
      required this.balance,
      required this.userName,
      this.walletAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 180.h,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10.r)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                AssetStrings.outlinedEthLogo,
                height: 100.h,
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Balance",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )),
                SizedBox(height: 5.h),
                Text("$balance ETH",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
          Positioned(
            bottom: 10.h,
            right: 10.w,
            child: Text(userName,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
