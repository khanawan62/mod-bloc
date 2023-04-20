import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/custom_error_widget.dart';
import 'audio_cubit.dart';
import 'audio_state.dart';
import 'genre_list.dart';

class BodyListView extends StatelessWidget {
  const BodyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
            builder: ((context, state) {
              if (state is AudioLoadedState) {
                return ListView.separated(
              itemBuilder: (context, idx) {
                return Container(
                  color: idx.isEven ? Colors.black45 : Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    child: GenreList(industry: state.audioUIModelList[idx].industry,
                    genres: state.audioUIModelList[idx].genres,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemCount: state.audioUIModelList.length);
              }
              if (state is AudioErrorState) {
                return CustomErrorWidget(errorMsg: state.errorMsg);
              }
              return Container();
            }), 
            );
  }
}