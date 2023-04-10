import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  @override
 List<Object?> get props => [];
}
class MovieInitEvent extends MovieEvent {
  @override
  List<Object?> get props => [];
}
class MoviErrorEvent extends MovieEvent {
  @override
  List<Object?> get props => [];
}