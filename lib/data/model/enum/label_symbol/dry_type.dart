// DRY_SUNNY_HANGER_KR(0, KR, "화창한 날 옷걸이에 걸어서"),
// DRY_CLOUD_HANGER_KR(1, KR, "흐린 날 옷걸이에 걸어서"),
// DRY_SUNNY_DOWN_KR(2, KR, "화창한 날 눕혀서"),
// DRY_CLOUD_DOWN_KR(3, KR, "흐린 날 눕혀서"),
// DRY_BLOWER_KR(4, KR, "비틀기 가능"),
// DRY_BLOWER_FORBIDDEN_KR(5, KR, "비틀기 불가"),
// DRY_MACHINE_KR(6, KR, "건조기 가능"),
// DRY_MACHINE_FORBIDDEN_KR(7, KR, "건조기 불가"),

enum DryType {
  DRY_SUNNY_HANGER_KR,
  DRY_CLOUD_HANGER_KR,
  DRY_SUNNY_DOWN_KR,
  DRY_CLOUD_DOWN_KR,
  DRY_BLOWER_KR,
  DRY_BLOWER_FORBIDDEN_KR,
  DRY_MACHINE_KR,
  DRY_MACHINE_FORBIDDEN_KR
}

DryType getDryTypeFromString(String value) {
  value = 'DryType.$value';
  return DryType.values
      .firstWhere((element) => element.toString() == value, orElse: () => null);
}

extension ParseToString on DryType {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String getUIDescription() {
    switch (this) {
      case DryType.DRY_SUNNY_HANGER_KR:
        return '화창한 날 옷걸이에 걸어서';
      case DryType.DRY_CLOUD_HANGER_KR:
        return '흐린 날 옷걸이에 걸어서';
      case DryType.DRY_SUNNY_DOWN_KR:
        return '화창한 날 눕혀서';
      case DryType.DRY_CLOUD_DOWN_KR:
        return '흐린 날 눕혀서';
      case DryType.DRY_BLOWER_KR:
        return '비틀기 가능';
      case DryType.DRY_BLOWER_FORBIDDEN_KR:
        return '비틀기 불가';
      case DryType.DRY_MACHINE_KR:
        return '건조기 가능';
      case DryType.DRY_MACHINE_FORBIDDEN_KR:
        return '건조기 불가';
      default:
        return '';
    }
  }

  String getUIIconName() {
    switch (this) {
      case DryType.DRY_SUNNY_HANGER_KR:
        return 'assets/icons/ic_dry_sunny_hanger_kr.svg';
      case DryType.DRY_CLOUD_HANGER_KR:
        return 'assets/icons/ic_dry_cloud_hanger_kr.svg';
      case DryType.DRY_SUNNY_DOWN_KR:
        return 'assets/icons/ic_dry_sunny_down_kr.svg';
      case DryType.DRY_CLOUD_DOWN_KR:
        return 'assets/icons/ic_dry_cloud_down_kr.svg';
      case DryType.DRY_BLOWER_KR:
        return 'assets/icons/ic_dry_blower_kr.svg';
      case DryType.DRY_BLOWER_FORBIDDEN_KR:
        return 'assets/icons/ic_dry_blower_forbidden_kr.svg';
      case DryType.DRY_MACHINE_KR:
        return 'assets/icons/ic_dry_machine_kr.svg';
      case DryType.DRY_MACHINE_FORBIDDEN_KR:
        return 'assets/icons/ic_dry_machine_forbidden_kr.svg';
      default:
        return 'assets/icons/ic_label_error.svg';
    }
  }
}
