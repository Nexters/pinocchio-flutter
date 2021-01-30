import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingEvent {}

class OnboardingNext extends OnboardingEvent {}

class OnboardingSlide extends OnboardingEvent {
  int page;
  OnboardingSlide(this.page);
}

class OnboardingSkip extends OnboardingEvent {}