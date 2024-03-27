part of 'dashboard_bloc.dart';


@immutable 
sealed  class DashboardEvent  {
}

class DashboardInitialFetchEvent extends DashboardEvent {
  List<Object> get props => [];
}