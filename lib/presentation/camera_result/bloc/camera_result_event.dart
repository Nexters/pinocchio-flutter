import 'package:equatable/equatable.dart';

abstract class CameraResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoDataRequested extends CameraResultEvent {
  final String category;
  final String filePath;

  PhotoDataRequested(this.category, this.filePath);

  @override
  List<Object> get props => [category, filePath];
}
