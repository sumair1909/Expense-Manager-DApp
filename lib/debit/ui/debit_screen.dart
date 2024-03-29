import 'package:expense_manager/credit/ui/credit_screen.dart';
import 'package:expense_manager/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_manager/dashboard/ui/widgets/outlined_button.dart';
import 'package:expense_manager/models/transaction_model.dart';
import 'package:expense_manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DebitScreen extends StatefulWidget {
  final DashboardBloc dashboardBloc;
  const DebitScreen({super.key, required this.dashboardBloc});

  @override
  State<DebitScreen> createState() => _DebitScreenState();
}

// late TextEditingController addressController;
late TextEditingController amountController;
late TextEditingController reasonController;

class _DebitScreenState extends State<DebitScreen> {
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
              "Debit Details",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
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
                            buttonText: "Debit",
                            onTap: () {
                              widget.dashboardBloc.add(DashboardWithdrawEvent(
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
