import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_events.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_state.dart';

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
    hideTimer = Timer(const Duration(seconds: 4), () {
      emit(HideControls());
    });
  }

  ControlsBloc() : super(InitControlsState()) {
    emit(ShowControls()); 
    ///above line ensures that controls 
    ///are shown when the video loads
    resetTimer ();
    ///above call will automcatilly hide the
    ///controls when screen is not touched
    ///and when the video loads
    on<ToggleControlsRightAway>((event, emit) {
      resetTimer ();
      ///the reaseson why resetTimer() is called at
      ///line above is we want to hide the controls
      ///is when screen is touched or when no control 
      ///button was pressed 
      if (state is ShowControls) {
        emit(HideControls());
      } else {
        emit(ShowControls());
      }
    });

    on <HideControlsAfterDelay>((event, emit) {
      resetTimer();
    });
  }
}
