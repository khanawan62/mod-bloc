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
  final List <File> files;
  const FilePickLoaded({required this.fileCount, required this.files});
}
