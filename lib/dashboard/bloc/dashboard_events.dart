part of 'dashboard_bloc.dart';


@immutable 
sealed  class DashboardEvent  {
}

class DashboardInitialFetchEvent extends DashboardEvent {
  List<Object> get props => [];
}

class DashboardDepositEvent extends DashboardEvent {
  final TransactionModel transactionModel;
  
  DashboardDepositEvent({required this.transactionModel});
  List<Object> get props => [transactionModel];
} 

class DashboardWithdrawEvent extends DashboardEvent {
  final TransactionModel transactionModel;
  
  DashboardWithdrawEvent({required this.transactionModel});
  List<Object> get props => [transactionModel];
}