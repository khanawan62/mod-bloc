import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'newcontrols_event.dart';
part 'newcontrols_state.dart';

class NewcontrolsBloc extends Bloc<NewcontrolsEvent, NewcontrolsState> {
  Timer? hideTimer; //without the question mark, the timer won't work

  resetTimer() {
    /*
    Is called at almost every button
    Always executes from the scrach as we cancel it everytime and then start it,
    or in other words we restart (reset) it
    */
    hideTimer?.cancel();
    startTimer();
  }

  cancelHideTimer() {
    hideTimer?.cancel();
  }

  startTimer() {
    hideTimer = Timer(const Duration(seconds: 5), () {
      emit(NewcontrolsHideState());
      resetTimer();
    });
  }

  NewcontrolsBloc() : super(NewcontrolsInitialState()) {
    emit(NewcontrolsShowState());

    on<ToggleNewControlsRightAway>((event, emit) {
      resetTimer();

      ///the reaseson why resetTimer() is called at
      ///line above is we want to hide the controls
      ///is when screen is touched or when no control
      ///button was pressed
      if (state is NewcontrolsShowState) {
        emit(NewcontrolsHideState());
      } else {
        emit(NewcontrolsShowState());
      }
    });
    on<HideNewControlsAfterDelay>((event, emit) {
      resetTimer();
    });
  }
  
}
