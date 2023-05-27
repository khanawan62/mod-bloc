import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mod_bloc/repos/services/settings_service.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final SettingsService _settingsService = SettingsService();
  PasswordCubit() : super(PasswordInitial());

  onPressedSubmit(String pswd) async {
    String password = await _settingsService.getSettingsPassword();
    if (password == pswd) {
      emit(PasswordValid());
    } else {
      emit(const PasswordInvalid(errorMsg: "Incorrect password"));
    }
  }
  reset () {
    emit(PasswordInitial());
  }
}
