part of 'ebook_bloc.dart';

abstract class EbookEvent extends Equatable {
  const EbookEvent();

  @override
  List<Object> get props => [];
}

class EbookInit extends EbookEvent {
  final String thumbnailUrl;
  const EbookInit({required this.thumbnailUrl});
}
