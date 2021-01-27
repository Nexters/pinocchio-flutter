import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnboardingFinish extends OnboardingEvent {}

class OnboardingCheck extends OnboardingEvent {}