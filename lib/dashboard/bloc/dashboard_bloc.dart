import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_events.dart';
part 'dashboard_states.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialFetchEvent>(dashboardInitialFetchEvent);


  }

  FutureOr<void> dashboardInitialFetchEvent(DashboardInitialFetchEvent event, Emitter<DashboardState> emit) {
    emit(DashboardLoadingState());
    try {
      // Fetch data from API
      emit(DashboardSuccessState());
    } catch (e) {
      emit(DashboardErrorState());
    }
  }
}
