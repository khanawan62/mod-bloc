import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/ui/shared/custom_error_widget.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';

class ThumbnailsScreen extends StatelessWidget {
  const ThumbnailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Thumbnails"),
      body: BackgroundGradient(
        widgetChild: Padding(
          padding: const EdgeInsets.only(left: 4, top: 15),
          child: BlocConsumer <ThumbnailsCubit, ThumbnailsState>(builder: (context, state) {
            if (state is ThumbnailsLoadedState) {
              return GridView.count(
                crossAxisCount: 4,
                 crossAxisSpacing: MediaQuery.of(context).size.height / 24,
                 mainAxisSpacing: MediaQuery.of(context).size.height / 14,
                scrollDirection: Axis.vertical,
                children: List.generate(state.thumbnails.length, (index) {
                  return Image.network(state.thumbnails[index], 
                  fit: BoxFit.fitHeight,
                  );
                }),
              );
            }
            if (state is ThumbnailsLoadingState) {
              return const CustomSpinner();
            }
            if (state is ThumbnailsErrorState) {
              return const CustomErrorWidget(errorMsg: "Failed connection");
            }
            return Container();
          }, listener: (context, state) {
            print (state.toString());
          }),
        ),
      ),
    );
  }
}