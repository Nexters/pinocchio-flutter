import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/onboarding/bloc/onboarding_event.dart';
import 'package:flutter_sancle/presentation/onboarding/bloc/onboarding_state.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  SharedPreferences _isOnboardingGuided;

  OnboardingBloc() : super(OnboardingInitial()){
    _loadPref();
  }

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if(event is OnboardingFinish){
      _isOnboardingGuided.setBool(ONBOARDING_FLAG, true);
      yield OnboardingGuided();
    }

    if(event is OnboardingCheck){
      if(_isOnboardingGuided.getBool(ONBOARDING_FLAG)){
        yield OnboardingGuided();
      }
      else{
        yield OnboardingBefore();
      }
    }
  }

  void _loadPref() async{
    _isOnboardingGuided = await SharedPreferences.getInstance();
  }
}
