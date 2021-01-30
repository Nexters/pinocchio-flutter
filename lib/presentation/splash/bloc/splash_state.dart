import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class UserTokenCheckedFailure extends SplashState {
  final bool isAlreadyShownGuide;

  UserTokenCheckedFailure(this.isAlreadyShownGuide);

  @override
  List<Object> get props => [isAlreadyShownGuide];
}

class UserTokenCheckedSuccess extends SplashState {}
