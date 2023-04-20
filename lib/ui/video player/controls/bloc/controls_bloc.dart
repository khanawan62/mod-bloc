import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'controls_event.dart';
part 'controls_state.dart';

class ControlsBloc extends Bloc<ControlsEvent, ControlsState> {
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
      emit(ControlsHidden());
      resetTimer();
    });
  }

  ControlsBloc() : super(ControlsInitial()) {
      emit(ControlsShown());
      on<ControlsToggleRightAwayPressed>((event, emit) {
        resetTimer();
        ///the reaseson why resetTimer() is called at
        ///line above is we want to hide the controls
        ///is when screen is touched or when no control
        ///button was pressed
        if (state is ControlsShown) {
          emit(ControlsHidden());
        } else {
          emit(ControlsShown());
        }
      });
      
      on<ControlsHideAfterDelayPressed>((event, emit) {
        resetTimer();
      });
  }
}
