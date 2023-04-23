import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mod_bloc/repos/services/file_explorer_service.dart';

import '../../../utils/network_constants.dart';

part 'file_explorer_state.dart';

class FileExplorerCubit extends Cubit<FileExplorerState> {
  FileExplorerCubit() : super(FileExplorerInitial());
  final FileExplorerService _fileExplorerService = FileExplorerService();
  String baseUrlToGetFilesAndFolders = "${Constants.baseUrl}/getNames";

  onPressedGetFilesAndFolders(String param) async {
    emit(FileExplorerLoading());
    List<String> namesOfFilesAndFolders =
        await _fileExplorerService.getFileNames(baseUrlToGetFilesAndFolders + param);
    emit(FileExplorerLoaded(namesOfFilesAndFolders: namesOfFilesAndFolders));
  }
}
