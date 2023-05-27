import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/constants/network_constants.dart';

part 'ebook_event.dart';
part 'ebook_state.dart';

class EbookBloc extends Bloc<EbookEvent, EbookState> {
  EbookBloc() : super(EbookInitial()) {
    on<EbookInit>((event, emit) {
      String ebookURL =
          "${Constants.ebookBaseUrl}${event.thumbnailUrl.substring(Constants.stringCutterNumber).split(".").first}.pdf";
      emit(EbookLoaded(ebookURL: ebookURL));
    });
  }
}
