import 'package:expense_manager/credit/ui/credit_screen.dart';
import 'package:expense_manager/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_manager/dashboard/ui/widgets/account_details_card.dart';
import 'package:expense_manager/dashboard/ui/widgets/outlined_button.dart';
import 'package:expense_manager/dashboard/ui/widgets/transaction_card.dart';
import 'package:expense_manager/debit/ui/debit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardBloc _dashboardBloc = DashboardBloc();
  @override
  void initState() {
    super.initState();
    _dashboardBloc.add(DashboardInitialFetchEvent());
  }

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
        body: BlocConsumer<DashboardBloc, DashboardState>(
            bloc: _dashboardBloc,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case DashboardLoadingState:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case DashboardErrorState:
                  return const Center(
                    child: Text("Error"),
                  );
                case DashboardSuccessState:
                  final data = state as DashboardSuccessState;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AccountDetailsCard(
                          balance: data.balance.toString(),
                          userName: "SUMAIR BAIS"),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomOutlinedButton(
                              buttonText: "Debit",
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DebitScreen()))),
                          SizedBox(width: 30.w),
                          CustomOutlinedButton(
                              buttonText: "Credit",
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreditScreen()))),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, bottom: 10.h, top: 10.h),
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
                      data.transactions.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 20.w, bottom: 20.h),
                                  itemCount: data.transactions.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10.h),
                                  itemBuilder: (context, index) =>
                                      TransactionCard(
                                        reason: data.transactions[index].reason,
                                        amount: data.transactions[index].amount,
                                        date:
                                            data.transactions[index].timestamp,
                                      )))
                          : Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 120.h),
                              child: Text("No transactions :( ",
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  )),
                            )
                    ],
                  );
                default:
                  return const SizedBox();
              }
            }));
  }
}
