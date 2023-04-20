import 'package:equatable/equatable.dart';

abstract class AudioPlayerEvent extends Equatable {}

class OnInitEvent extends AudioPlayerEvent {
  List<String> thumbnails;
  int passedIndex;
  OnInitEvent({required this.thumbnails, required this.passedIndex});
  @override
  List<Object?> get props => [];
}

class OnPressedNext extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

class OnPressedPrevious extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

class OnPressedPlay extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

class OnPressedPause extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}
class OnPressedExit extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}
class OnGetTimeEvent extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

