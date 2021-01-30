import 'package:flutter_sancle/data/prefs/onboarding_guide_manager.dart';

class OnboardingRepository {
  Future<bool> getIsGuide() => OnboardingGuideManager.instance.getIsGuide();

  Future<void> setIsGuide(bool guide) =>
      OnboardingGuideManager.instance.setIsGuide(guide);
}
