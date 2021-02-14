// FORBIDDEN_KR(0, KR, "다림질 불가"),
// IRONING_80_120_KR(1, KR, "80~120도 가능"),
// IRONING_80_120_FABRIC_KR(2, KR, "80~120도 천 깔고만 가능"),
// IRONING_140_160_KR(3, KR, "140~160도 가능"),
// IRONING_140_160_FABRIC_KR(4, KR, "140~160도 천 깔고만 가능"),
// IRONING_180_210_KR(5, KR, "180~210도 가능"),
// IRONING_180_210_FABRIC_KR(6, KR, "180~210도 천 깔고만 가능"),

enum IroningType {
  FORBIDDEN_KR,
  IRONING_80_120_KR,
  IRONING_80_120_FABRIC_KR,
  IRONING_140_160_KR,
  IRONING_140_160_FABRIC_KR,
  IRONING_180_210_KR,
  IRONING_180_210_FABRIC_KR,
}

IroningType getIroningTypeFromString(String value) {
  value = 'IroningType.$value';
  return IroningType.values
      .firstWhere((element) => element.toString() == value, orElse: () => null);
}

extension ParseToString on IroningType {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String getUIDescription() {
    switch (this) {
      case IroningType.FORBIDDEN_KR:
        return '다림질 불가';
      case IroningType.IRONING_80_120_KR:
        return '80~120도 가능';
      case IroningType.IRONING_80_120_FABRIC_KR:
        return '80~120도 천 깔고만 가능';
      case IroningType.IRONING_140_160_KR:
        return '140~160도 가능';
      case IroningType.IRONING_140_160_FABRIC_KR:
        return '140~160도 천 깔고만 가능';
      case IroningType.IRONING_180_210_KR:
        return '180~210도 가능';
      case IroningType.IRONING_180_210_FABRIC_KR:
        return '180~210도 천 깔고만 가능';
      default:
        return '';
    }
  }

  String getUIIconName() {
    switch (this) {
      case IroningType.FORBIDDEN_KR:
        return 'assets/icons/ic_iron_forbidden_kr.svg';
      case IroningType.IRONING_80_120_KR:
        return 'assets/icons/ic_iron_80_120_kr.svg';
      case IroningType.IRONING_80_120_FABRIC_KR:
        return 'assets/icons/ic_iron_80_120_fabric_kr.svg';
      case IroningType.IRONING_140_160_KR:
        return 'assets/icons/ic_iron_140_160_kr.svg';
      case IroningType.IRONING_140_160_FABRIC_KR:
        return 'assets/icons/ic_iron_140_160_fabric_kr.svg';
      case IroningType.IRONING_180_210_KR:
        return 'assets/icons/ic_iron_180_210_kr.svg';
      case IroningType.IRONING_180_210_FABRIC_KR:
        return 'assets/icons/ic_iron_180_210_fabric_kr.svg';
      default:
        return '';
    }
  }
}
