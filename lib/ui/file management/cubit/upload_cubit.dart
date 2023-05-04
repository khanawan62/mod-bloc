import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mod_bloc/utils/network_constants.dart';
part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitial());

  uploadFilesWithHttp(List<File> files, String uploadPath) async {
    http.MultipartRequest;
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Constants.baseUrl}/up" + "?folder=${uploadPath}"));
    request.fields["folderPath"] = uploadPath;
    for (var file in files) {
      var fileToUpload = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(fileToUpload);
    }
    await request.send();
    emit(Uploaded());
  }

  streamUpload(List<File> files, String uploadPath) async {
    int sent = 0;
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Constants.baseUrl}/up" + "?folder=${uploadPath}"));
    request.fields["folderPath"] = uploadPath;
    for (var file in files) {
      var fileToUpload = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(fileToUpload);
    }
   http.StreamedResponse response = await http.Client().send(request);
   response.stream.listen((value) { 
    for (int i in value) {
      print (i);
    }
   });
   emit(Uploaded());
  }

  onPressedSend(List<File> files, String uploadPath) async {
    int fileNumber;
    var dio = Dio();
    dio.options.connectTimeout = const Duration(minutes: 100);
    var formData = FormData();
    for (int i = 0; i < files.length; i++) {
      fileNumber = i + 1;
      String fileName = files[i].path.split('/').last;
      formData = FormData.fromMap({
        "folderPath": uploadPath,
        "file": await MultipartFile.fromFile(files[i].path, filename: fileName),
      });
      var response = await dio.post(
          "${Constants.baseUrl}/up",
          data: formData, onSendProgress: (int sent, int total) {
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
