import 'package:flutter_bloc/flutter_bloc.dart';

class PlayPauseCubit extends Cubit <bool> {
    ///this class is not needed and should be deleted

  bool buttonPressed = false;
  PlayPauseCubit() : super (false);

  toggleButton () {
    buttonPressed = !buttonPressed;
    emit(buttonPressed);
  }
  resetButtonPressedValue () {
    buttonPressed = false;
    emit(buttonPressed);
  }
}