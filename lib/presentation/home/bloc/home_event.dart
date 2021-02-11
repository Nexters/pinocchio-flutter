import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeEvent {}

class HomePageSlide extends HomeEvent {
  int page;

  HomePageSlide(this.page);
}

class HomeToMypage extends HomeEvent {}

class PermissionRequested extends HomeEvent {}
