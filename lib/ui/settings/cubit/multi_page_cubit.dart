import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mod_bloc/repos/services/settings_service.dart';

part 'multi_page_state.dart';

class MultiPageCubit extends Cubit<MultiPageState> {
  MultiPageCubit() : super(MultiPageInitial()) {
    getState();
    /// at constructor we need to know the state
    /// of switch
  }
  final SettingsService _settingsService = SettingsService();

  getState() async {
    bool isMenuMultiPage = await _settingsService.getIsMenuMultipPage();
    if (isMenuMultiPage) {
      emit(MultiPageTrue());
    } else {
      emit(MultiPageFalse());
    }
  }

  onChangedPressed(bool val) {
    if (val) {
      emit(MultiPageTrue());
    } else {
      emit(MultiPageFalse());
    }
    ///above lines ensure that switch 
    ///state is changed right away by emitting states
    _settingsService.setIsMenuMultipPage(val);
  }
}
