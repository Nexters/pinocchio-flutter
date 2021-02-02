import 'package:equatable/equatable.dart';

abstract class MyPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MyPageInitial extends MyPageEvent {}