part of 'file_explorer_cubit.dart';

abstract class FileExplorerState extends Equatable {
  const FileExplorerState();

  @override
  List<Object> get props => [];
}

class FileExplorerInitial extends FileExplorerState {}

class FileExplorerLoading extends FileExplorerState {}

class FileExplorerLoaded extends FileExplorerState {
  final List<String> namesOfFilesAndFolders;
  const FileExplorerLoaded({required this.namesOfFilesAndFolders});
  @override
  List<Object> get props => [namesOfFilesAndFolders];
}
