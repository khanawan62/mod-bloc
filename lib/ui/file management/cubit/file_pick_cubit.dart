import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'file_pick_state.dart';

class FilePickCubit extends Cubit<FilePickState> {
  FilePickCubit() : super(FilePickInitial());

  onPressedFilePick () async {
    emit(FilePickLoading());
    List<File> files = [];
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      files = result.paths.map((path) => File(path.toString())).toList();
    }
    emit(FilePickLoaded(fileCount: files.length));
  }
}
