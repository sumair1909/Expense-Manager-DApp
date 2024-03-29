import 'package:expense_manager/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_manager/dashboard/ui/widgets/outlined_button.dart';
import 'package:expense_manager/models/transaction_model.dart';
import 'package:expense_manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditScreen extends StatefulWidget {
  final DashboardBloc dashboardBloc;
  const CreditScreen({super.key, required this.dashboardBloc});

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

// late TextEditingController addressController;
late TextEditingController amountController;
late TextEditingController reasonController;

class _CreditScreenState extends State<CreditScreen> {
  @override
  void initState() {
    super.initState();
    // addressController = TextEditingController();
    amountController = TextEditingController();
    reasonController = TextEditingController();
  }

  @override
  void dispose() {
    // addressController.dispose();
    amountController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Credit Details",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.green),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: ListView(
              children: [
                // CustomTextFormField(
                //     hintText: "Enter address", controller: addressController),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: CustomTextFormField(
                      hintText: "Enter amount",
                      controller: amountController,
                      numberOnly: true),
                ),
                CustomTextFormField(
                    hintText: "Enter reason",
                    controller: reasonController,
                    reasonOnly: true),
                SizedBox(height: 20.h),
                // Add a button here
                Row(
                  children: [
                    Expanded(
                        child: CustomOutlinedButton(
                            buttonText: "CREDIT",
                            onTap: () {
                              widget.dashboardBloc.add(DashboardDepositEvent(
                                  transactionModel: TransactionModel(
                                      address: address,
                                      amount: int.parse(amountController.text),
                                      reason: reasonController.text,
                                      timestamp: DateTime.now())));
                              Navigator.pop(context);
                            })),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? numberOnly;
  final bool? reasonOnly;
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.numberOnly,
      this.reasonOnly});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: GoogleFonts.spaceGrotesk(
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller,
          keyboardType: numberOnly ?? false ? TextInputType.number : null,
          textCapitalization: reasonOnly ?? false
              ? TextCapitalization.sentences
              : TextCapitalization.none,
          cursorColor: Colors.black54,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            hintStyle: GoogleFonts.spaceGrotesk(
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
