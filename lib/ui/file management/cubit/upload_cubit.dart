import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mod_bloc/utils/network_constants.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitial());

  onPressedSend(List<File> files, String uploadPath) async {
    int fileNumber;
    var dio = Dio();
    var formData = FormData();
    for (int i = 0; i < files.length; i++) {
      fileNumber = i + 1;
      String fileName = files[i].path.split('/').last;
      formData = FormData.fromMap({
        "folderPath": uploadPath,
        "file": await MultipartFile.fromFile(files[i].path, filename: fileName),
      });
      var response = await dio.post("${Constants.baseUrl}/up", data: formData,
          onSendProgress: (int sent, int total) {
        double percentage = (sent / total) * 100;
        emit(Uploading(
            percentage: percentage.toString(),
            fileNumber: fileNumber.toString(),
            fileCount: files.length.toString()));
        if (percentage == 100.0 && fileNumber == files.length) {
          emit(Uploaded());
        }
      });
    }
  }
}