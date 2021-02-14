// DRY_CLEANING_KR(0, KR, "드라이 클리닝 가능"),
// DRY_CLEANING_FORBIDDEN_KR(1, KR, "드라이 클리닝 불가"),
// DRY_CLEANING_OIL_KR(2, KR, "석유계 드라이 클리닝 가능"),
// DRY_CLEANING_SELF_FORBIDDEN_KR(3, KR, "셀프 드라이 클리닝 불가"),

enum DryCleaningType {
  DRY_CLEANING_KR,
  DRY_CLEANING_FORBIDDEN_KR,
  DRY_CLEANING_OIL_KR,
  DRY_CLEANING_SELF_FORBIDDEN_KR
}

DryCleaningType getDryCleaningTypeFromString(String value) {
  value = 'DryCleaningType.$value';
  return DryCleaningType.values
      .firstWhere((element) => element.toString() == value, orElse: () => null);
}

extension ParseToString on DryCleaningType {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String getUIDescription() {
    switch (this) {
      case DryCleaningType.DRY_CLEANING_KR:
        return '드라이 클리닝 가능';
      case DryCleaningType.DRY_CLEANING_FORBIDDEN_KR:
        return '드라이 클리닝 불가';
      case DryCleaningType.DRY_CLEANING_OIL_KR:
        return '석유계 드라이 클리닝 가능';
      case DryCleaningType.DRY_CLEANING_SELF_FORBIDDEN_KR:
        return '셀프 드라이 클리닝 불가';
      default:
        return '';
    }
  }

  String getUIIconName() {
    switch (this) {
      case DryCleaningType.DRY_CLEANING_KR:
        return 'assets/icons/ic_dry_cleaning_kr.svg';
      case DryCleaningType.DRY_CLEANING_FORBIDDEN_KR:
        return 'assets/icons/ic_dry_cleaning_forbidden_kr.svg';
      case DryCleaningType.DRY_CLEANING_OIL_KR:
        return 'assets/icons/ic_dry_cleaning_oil_kr.svg';
      case DryCleaningType.DRY_CLEANING_SELF_FORBIDDEN_KR:
        return 'assets/icons/ic_dry_cleaning_self_forbidden_kr.svg';
      default:
        return '';
    }
  }
}
