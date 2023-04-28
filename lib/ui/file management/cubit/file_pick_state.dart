part of 'file_pick_cubit.dart';

abstract class FilePickState extends Equatable {
  const FilePickState();

  @override
  List<Object> get props => [];
}

class FilePickInitial extends FilePickState {}

class FilePickLoading extends FilePickState {}

class FilePickLoaded extends FilePickState {
  final int fileCount;
  const FilePickLoaded({required this.fileCount});
}
