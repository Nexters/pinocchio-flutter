import 'dart:convert';

import 'package:flutter_sancle/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingGuideManager {
  static final OnboardingGuideManager _onboardingGuideManager =
      new OnboardingGuideManager._internal();

  static OnboardingGuideManager get instance => _onboardingGuideManager;

  OnboardingGuideManager._internal();

  Future<void> setIsGuide(bool guided) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ONBOARDING_FLAG, guided);
  }

  Future<bool> getIsGuide() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ONBOARDING_FLAG);
  }
}
