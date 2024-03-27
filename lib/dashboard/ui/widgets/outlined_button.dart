import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomOutlinedButton({super.key, required this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(222, 255, 255, 255)),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.r))),
      ),
      child: Text(
        buttonText,
        style: GoogleFonts.lato(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: buttonText == 'Debit' ? Colors.red : Colors.green),
      ),
    );
  }
}
