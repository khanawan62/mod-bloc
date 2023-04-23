import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_explorer_cubit.dart';
import 'package:mod_bloc/ui/file%20management/widgets/folder_widget.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/utils/app_size.dart';

class FileExplorerScreen extends StatefulWidget {
  const FileExplorerScreen({super.key});

  @override
  State<FileExplorerScreen> createState() => _FileExplorerScreenState();
}

class _FileExplorerScreenState extends State<FileExplorerScreen> {
  @override
  void initState() {
    context.read<FileExplorerCubit>().onPressedGetFilesAndFolders("");
    super.initState();
  }
  List <String> appbarTextList = ["Home"];
  List<String> optionalUrlParams = [
    "?folder1=",
    "&folder2=",
    "&folder3=",
    "&folder4="
  ];

  String concatenatedPath = "";
  ///above concatenatedPath variable is concatenation
  ///of optionalUrlParam with the name of the clicked
  ///folder name. I/e ?folder1=images or ?folder1=images&folder2=movies
  List<String> concatenatedPathList = [];
  ///above concatenatedPathList contains the concatenation
  ///of optionalUrlParam with the name of the clicked
  ///folder name item. I/e [?folder1=images] or [?folder1=images, ?folder1=images&folder2=movies]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StatefulBuilder(builder: (context, setState) {
          return Text(
            appbarTextList[concatenatedPathList.length],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700));
        }),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          appbarTextList.length == 1 ? const SizedBox() : IconButton(
              onPressed: () {
                setState(() {
                    appbarTextList.removeAt(appbarTextList.length -1);
                  });
                if (concatenatedPathList.length == 1) {
                  context
                      .read<FileExplorerCubit>()
                      .onPressedGetFilesAndFolders("");
                      ///when we reach the home, empty string
                      ///should be passed in above call
                  concatenatedPathList.clear();
                  concatenatedPath = "";
                  ///when we reach the home, we should
                  ///reset the variables to start over  
                } else {
                  concatenatedPathList.removeLast();
                  context.read<FileExplorerCubit>().onPressedGetFilesAndFolders(
                      concatenatedPathList[concatenatedPathList.length - 1]);
                  concatenatedPath = concatenatedPathList[concatenatedPathList.length - 1];
                  ///above line will keep the 2nd last item
                  ///of the path list. W/O this line, the system 
                  ///won't work
                }
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: BackgroundGradient(
        widgetChild: BlocBuilder<FileExplorerCubit, FileExplorerState>(
            builder: (context, state) {
          if (state is FileExplorerLoaded) {
            return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: AppSize.screenHeight / 24.66,
                mainAxisSpacing: AppSize.screenHeight / 14.8,
                scrollDirection: Axis.vertical,
                children:
                    List.generate(state.namesOfFilesAndFolders.length, (index) {
                  return GestureDetector(
                      onLongPress: () {},
                      onTap: () {
                        if (!state.namesOfFilesAndFolders[index]
                            .contains(".")) {
                              setState(() {
                                appbarTextList.add(state.namesOfFilesAndFolders[index]);
                              });
                              ///above if condition will make sure that
                              ///only folders are clickable
                              
                              ///as we click the foler widget
                              ///we can access the folder name with state.namesOfFilesAndFolders[index]
                              ///and this clicked folder name will be concatenated with 
                              ///optional param list item.
                              ///We pass pathList.index as the index of 
                              ///the optionalUrlParams list. 
                              ///As the concatenatedPath is added to pathList,
                              ///this list will grow with button clicks
                          concatenatedPath +=
                              optionalUrlParams[concatenatedPathList.length] +
                                  state.namesOfFilesAndFolders[index];
                                  ///we add the concatenated path to the 
                                  ///concatenatedPathList array
                          concatenatedPathList.add(concatenatedPath);
                          context
                              .read<FileExplorerCubit>()
                              .onPressedGetFilesAndFolders(
                                  concatenatedPathList[concatenatedPathList.length - 1]);
                                  ///we make the network request in above call
                                  ///by passing the last item of the concatenatedPathList list
                        }
                      },
                      child: FolderWidget(
                          folderName: state.namesOfFilesAndFolders[index]));
                }));
          }
          return const CustomSpinner();
        }),
      ),
    );
  }
}
