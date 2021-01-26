import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class KakaoTalkInstalled extends LoginEvent {}

class KakaoTalkLoginRequested extends LoginEvent {}
