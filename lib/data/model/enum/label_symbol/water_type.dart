// HAND_KR(0, KR,"손 세탁 가능, 중성 세제"),
// FORBIDDEN_KR(1,KR, "물세탁 불가"),
// WASHER_30_NEUTRAL_KR(2,KR, "세탁기 약 30도 중성"),
// WASHER_ABOUT_40_KR(3, KR,"세탁기 약 40도"),
// WASHER_40_KR(4, KR,"세탁기 40도"),
// WASHER_60_KR(5, KR,"세탁기 60도"),
// WASHER_90_KR(6, KR,"세탁기 95도"),

enum WaterWashingType {
  HAND_KR,
  FORBIDDEN_KR,
  WASHER_30_NEUTRAL_KR,
  WASHER_ABOUT_40_KR,
  WASHER_40_KR,
  WASHER_60_KR,
  WASHER_90_KR
}

WaterWashingType getWaterWashingTypeFromString(String value) {
  value = 'WaterWashingType.$value';
  return WaterWashingType.values
      .firstWhere((element) => element.toString() == value, orElse: () => null);
}

extension ParseToString on WaterWashingType {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String getUIDescription() {
    switch (this) {
      case WaterWashingType.HAND_KR:
        return '손 세탁 가능, 중성 세제';
      case WaterWashingType.FORBIDDEN_KR:
        return '물세탁 불가';
      case WaterWashingType.WASHER_30_NEUTRAL_KR:
        return '세탁기 약 30도 중성';
      case WaterWashingType.WASHER_ABOUT_40_KR:
        return '세탁기 약 40도';
      case WaterWashingType.WASHER_40_KR:
        return '세탁기 40도';
      case WaterWashingType.WASHER_60_KR:
        return '세탁기 60도';
      case WaterWashingType.WASHER_90_KR:
        return '세탁기 95도';
      default:
        return "";
    }
  }

  String getUIIconName() {
    switch (this) {
      case WaterWashingType.HAND_KR:
        return 'assets/icons/ic_hand_kr.svg';
      case WaterWashingType.FORBIDDEN_KR:
        return 'assets/icons/ic_water_washing_forbidden_kr.svg';
      case WaterWashingType.WASHER_30_NEUTRAL_KR:
        return 'assets/icons/ic_washer_30_neutral_kr.svg';
      case WaterWashingType.WASHER_ABOUT_40_KR:
        return 'assets/icons/ic_washer_about_40_kr.svg';
      case WaterWashingType.WASHER_40_KR:
        return 'assets/icons/ic_washer_40_kr.svg';
      case WaterWashingType.WASHER_60_KR:
        return 'assets/icons/ic_washer_60_kr.svg';
      case WaterWashingType.WASHER_90_KR:
        return 'assets/icons/ic_washer_95_kr.svg';
      default:
        return "";
    }
  }
}
