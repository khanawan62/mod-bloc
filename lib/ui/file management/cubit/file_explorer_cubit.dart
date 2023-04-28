import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mod_bloc/repos/services/file_explorer_service.dart';
import 'package:http/http.dart' as http;
import '../../../utils/network_constants.dart';

part 'file_explorer_state.dart';

class FileExplorerCubit extends Cubit<FileExplorerState> {
  FileExplorerCubit() : super(FileExplorerInitial());
  final FileExplorerService _fileExplorerService = FileExplorerService();
  String baseUrlToGetFilesAndFolders = "${Constants.baseUrl}/getNames";

  onPressedGetFilesAndFolders(String optionlParams) async {
    emit(FileExplorerLoading());
    List<String> namesOfFilesAndFolders = await _fileExplorerService
        .getFileNames(baseUrlToGetFilesAndFolders + optionlParams);
    emit(FileExplorerLoaded(namesOfFilesAndFolders: namesOfFilesAndFolders));
  }

  List<String> appbarTextList = ["Home"];

  ///above list item will be used in app bar text
  List<String> optionalUrlParams = [
    "?folder1=",
    "&folder2=",
    "&folder3=",
    "&folder4="
  ];

  String getUploadPath() {
    String uploadPath = "";
    for (int i = 1; i < appbarTextList.length; i++) {
      uploadPath += "/${appbarTextList[i]}";
    }
    return uploadPath;
  }

  String concatenatedPath = "";

  ///above concatenatedPath variable is concatenation
  ///of optionalUrlParam with the name of the clicked
  ///folder name. I.e ?folder1=images or ?folder1=images&folder2=movies
  List<String> concatenatedPathList = [];

  ///above concatenatedPathList contains the concatenation
  ///of optionalUrlParam with the name of the clicked
  ///folder name item.
  ///I.e [?folder1=images] or [?folder1=images, ?folder1=images&folder2=movies]

  void goBack() {
    appbarTextList.removeAt(appbarTextList.length - 1);

    ///call setstate in ui while calling this function
    /// and it will show the folder name in app bar
    ///correctly when back button is pressed
    if (concatenatedPathList.length == 1) {
      onPressedGetFilesAndFolders("");

      ///when we reach the home, empty string
      ///should be passed in above call
      concatenatedPathList.clear();
      concatenatedPath = "";

      ///when we reach the home, we should
      ///reset the variables to start over
    } else {
      concatenatedPathList.removeLast();
      onPressedGetFilesAndFolders(concatenatedPathList.last);
      concatenatedPath = concatenatedPathList.last;

      ///above line will keep the 2nd last item
      ///of the path list. W/O this line, the system
      ///won't work
    }
  }

  onPressedRemove(String filePath, String fileName) async {
    String removeURL =
        "${Constants.baseUrl}/rm?folder=$filePath/$fileName";
    var res = await http.get(Uri.parse(removeURL));
    onPressedGetFilesAndFolders(concatenatedPathList.last);

    ///concatenatedPathList.last contains the currently
    ///opened folder
  }
}
