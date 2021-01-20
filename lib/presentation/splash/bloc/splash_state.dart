import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class UserTokenCheckedFailure extends SplashState {}

class UserTokenCheckedSuccess extends SplashState {}
