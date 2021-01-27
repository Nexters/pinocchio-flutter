import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingGuided extends OnboardingState {}

class OnboardingBefore extends OnboardingState {}