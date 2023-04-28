part of 'multi_page_cubit.dart';

abstract class MultiPageState extends Equatable {
  const MultiPageState();

  @override
  List<Object> get props => [];
}

class MultiPageInitial extends MultiPageState {}
class MultiPageTrue extends MultiPageState {}
class MultiPageFalse extends MultiPageState {}
