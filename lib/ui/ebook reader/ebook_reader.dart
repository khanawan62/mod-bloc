import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:mod_bloc/ui/ebook%20reader/bloc/ebook_bloc.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';

class EbookReader extends StatelessWidget {
  const EbookReader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Ebook Reader"),
      body: BlocBuilder<EbookBloc, EbookState>(
        builder: (context, state) {
          if (state is EbookLoaded) {
            return const PDF().fromUrl(state.ebookURL);
          }
          return const CustomSpinner();
        },
      ),
    );
  }
}
