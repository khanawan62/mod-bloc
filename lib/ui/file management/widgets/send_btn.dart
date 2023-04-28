import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_pick_cubit.dart';

class SendBtn extends StatelessWidget {
  const SendBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilePickCubit, FilePickState>(
      builder: (context, state) {
        if (state is FilePickLoaded ) {
          return CupertinoButton.filled(child: const Text("Send"), onPressed: () {});
        }
        return const SizedBox();
      },
    );
  }
}
