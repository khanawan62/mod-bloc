import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/services/connection_service.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_state.dart';

class ConnectionCubit extends Cubit<APIConnectionState> {
  StreamSubscription? _streamSubscription;
  final ConnectionService _connectionService = ConnectionService();
  int _timer = 0;

  ConnectionCubit() : super(ConnnectionInitState()) {
    _streamSubscription =
        _connectionService.checkConnectionStream().listen((event) {
          _timer ++; 
        if (_timer == 30) {///set accordingly in future
          emit(ConnectionTimedOutState());
          _streamSubscription?.cancel();
        }
      if (event == false) {
        emit(NoConnectionState());
      } else {
        emit(HasConnectionState());
      }
    });
  }
  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
