import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeStart extends HomeState {}

class MypageStart extends HomeState {}

class PermissionIsGranted extends HomeState {}

class PermissionIsDenied extends HomeState {}

class PermissionError extends HomeState {}

class StateIgnored extends HomeState {}

class GetNoti extends HomeState {}
