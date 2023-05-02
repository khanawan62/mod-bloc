import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_explorer_cubit.dart';
import 'package:mod_bloc/ui/file%20management/widgets/folder_widget.dart';
import 'package:mod_bloc/ui/file%20management/widgets/remove_file_dialog.dart';
import 'package:mod_bloc/ui/file%20management/widgets/upload_alert_dialog.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/utils/app_size.dart';

class FileExplorerScreen extends StatefulWidget {
  const FileExplorerScreen({super.key});

  @override
  State<FileExplorerScreen> createState() => _FileExplorerScreenState();
}

class _FileExplorerScreenState extends State<FileExplorerScreen> {
  late final FileExplorerCubit _fec; //fileExplorerCubit
  @override
  void initState() {
    context.read<FileExplorerCubit>().onPressedGetFilesAndFolders("");
    _fec = context.read<FileExplorerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<FileExplorerCubit>().concatenatedPathList.clear();
        context.read<FileExplorerCubit>().concatenatedPath = "";
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.file_upload),
          onPressed: () {
            showDialog(
                context: context, builder: (_) => const UploadAlertDialog());
          },
        ),
        appBar: AppBar(
          title: StatefulBuilder(builder: (context, setState) {
            return Text(_fec.appbarTextList[_fec.concatenatedPathList.length],

                ///since concatenatedPathList grows with button clicks
                ///and shrinks with back button, this is why
                ///its length is used an an index to appbarTextList
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700));
          }),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            _fec.appbarTextList.length == 1
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _fec.goBack();
                      });
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
                  children: List.generate(state.namesOfFilesAndFolders.length,
                      (index) {
                    return GestureDetector(
                        onLongPress: () {
                          if (state.namesOfFilesAndFolders[index]
                              .contains(".")) {
                            showDialog(
                                context: context,
                                builder: (_) => RemoveFileDialog(
                                    fileName:
                                        state.namesOfFilesAndFolders[index]));
                          }
                        },
                        onTap: () {
                          if (!state.namesOfFilesAndFolders[index]
                              .contains(".")) {
                            ///above if condition will make sure that
                            ///only folders are clickable
                            setState(() {
                              ///this setstate will correctly display
                              ///the clicked folder name in the app bar
                              _fec.appbarTextList
                                  .add(state.namesOfFilesAndFolders[index]);
                            });

                            ///as we click the folder widget
                            ///we can access the folder name with state.namesOfFilesAndFolders[index]
                            ///and this clicked folder name will be concatenated with
                            ///optional param list item.
                            ///We pass pathList.index as the index of
                            ///the optionalUrlParams list.
                            ///As the concatenatedPath is added to pathList,
                            ///this list will grow with button clicks
                            _fec.concatenatedPath += _fec.optionalUrlParams[
                                    _fec.concatenatedPathList.length] +
                                state.namesOfFilesAndFolders[index];

                            ///we add the concatenated path to the
                            ///concatenatedPathList array
                            _fec.concatenatedPathList
                                .add(_fec.concatenatedPath);
                            _fec.onPressedGetFilesAndFolders(
                                _fec.concatenatedPathList.last);

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
      ),
    );
  }
}
