part of 'upload_cubit.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object> get props => [];
}

class UploadInitial extends UploadState {}

class Uploading extends UploadState {
  final String percentage;
  final String fileCount;
  final String fileNumber;
  const Uploading ({required this.percentage, required this.fileCount, required this.fileNumber});
  @override
  List<Object> get props => [percentage, fileCount, fileNumber];
}

class Uploaded extends UploadState {}
