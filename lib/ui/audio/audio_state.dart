import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mod_bloc/repos/models/audio_ui_model.dart';

@immutable
abstract class AudioState extends Equatable {}

class AudioInitState extends AudioState {
  @override
  List<Object?> get props => [];
}

class AudioLoadingState extends AudioState {
  @override
  List<Object?> get props => [];
}

class AudioLoadedState extends AudioState {
  final List<AudioUIModel> audioUIModelList;

  AudioLoadedState({required this.audioUIModelList});
  @override
  List<Object?> get props => [audioUIModelList];
}

class AudioErrorState extends AudioState {
  final String errorMsg;
  AudioErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
