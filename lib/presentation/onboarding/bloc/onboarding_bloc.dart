import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/onboarding/bloc/onboarding_event.dart';
import 'package:flutter_sancle/presentation/onboarding/bloc/onboarding_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final StreamController _currentPageValueController = StreamController<int>();
  int value = 0;
  Stream<int> _currentPageValueStream;

  final _pageController = PageController();

  OnboardingBloc() : super(OnboardingStart()) {
    _currentPageValueStream = _currentPageValueController.stream;
  }

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event is OnboardingNext) {
      if (value == 2) {
        yield OnboardingEnd();
      }
      if (value < 2) {
        _currentPageValueController.add(++value);
        _pageController.jumpToPage(value);
        yield OnboardingProcessing();
      }
    }

    if (event is OnboardingSlide) {
      value = event.page;
      _pageController.jumpToPage(value);
      _currentPageValueController.add(value);
    }

    if (event is OnboardingSkip) {
      yield OnboardingEnd();
    }
  }

  Stream<int> get currentPageValue => _currentPageValueStream;

  get pageController => _pageController;
}
