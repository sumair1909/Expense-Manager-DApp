part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardErrorState extends DashboardState {}

class DashboardSuccessState extends DashboardState {}
