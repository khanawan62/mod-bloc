import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio/audio_state.dart';
import '../../repos/models/audio_ui_model.dart';
import '../../repos/services/audio_service.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioService _audioService = AudioService();
  AudioCubit() : super(AudioInitState()) {
    getAudioUI();
  }
  getAudioUI() async {
    emit(AudioLoadingState());
    List<AudioUIModel> audioUIModelList = [];
    try {
      audioUIModelList = await _audioService.getAudioUIModel();
      emit(AudioLoadedState(audioUIModelList: audioUIModelList));
    } catch (er) {
      emit(AudioErrorState(errorMsg: er.toString()));
    }
  }
}
