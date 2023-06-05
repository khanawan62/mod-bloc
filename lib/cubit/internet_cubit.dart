import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription <InternetConnectionStatus>? _subscription;
  InternetCubit() : super(InternetInitial()) {
     _subscription = InternetConnectionChecker().onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
         emit(InternetAvailable());
          break;
        case InternetConnectionStatus.disconnected:
          emit(InternetNotAvailable());
          break;
      }
    },
  );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
