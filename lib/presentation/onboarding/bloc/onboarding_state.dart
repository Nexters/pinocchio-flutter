import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnboardingStart extends OnboardingState {}

class OnboardingProcessing extends OnboardingState {}

class OnboardingEnd extends OnboardingState {}
