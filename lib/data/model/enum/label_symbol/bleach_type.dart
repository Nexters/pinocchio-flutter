// FORBIDDEN_KR(0, KR, "염소, 산소, 표백 불가"),
// CL_KR(1, KR, "산소, 표백 불가"),
// O2_KR(2, KR, "염소, 표백 불가"),
// ALL_KR(3, KR, "염소, 산소, 표백 가능"),
// O2_BLEACH_KR(4,KR, "산소, 표백 가능"),
// CL_BLEACH_KR(5,KR,"염소 표백 가능"),

enum BleachType {
  FORBIDDEN_KR,
  CL_KR,
  O2_KR,
  ALL_KR,
  O2_BLEACH_KR,
  CL_BLEACH_KR
}

extension ParseToString on BleachType {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String getUiDescription() {
    switch (this) {
      case BleachType.FORBIDDEN_KR:
        return '염소, 산소, 표백 불가';
      case BleachType.CL_KR:
        return '산소, 표백 불가';
      case BleachType.O2_KR:
        return '염소, 표백 불가';
      case BleachType.ALL_KR:
        return '염소, 산소, 표백 가능';
      case BleachType.O2_BLEACH_KR:
        return '산소, 표백 가능';
      case BleachType.CL_BLEACH_KR:
        return '염소 표백 가능';
      default:
        return '';
    }
  }

  String getUIIconName() {
    switch (this) {
      case BleachType.FORBIDDEN_KR:
        return 'assets/icons/ic_bleach_forbidden_kr.svg';
      case BleachType.CL_KR:
        return 'assets/icons/ic_cl_kr.svg';
      case BleachType.O2_KR:
        return 'assets/icons/ic_o2_kr.svg';
      case BleachType.ALL_KR:
        return 'assets/icons/ic_bleach_all.svg';
      case BleachType.O2_BLEACH_KR:
        return 'assets/icons/ic_o2_bleach_kr.svg';
      case BleachType.CL_BLEACH_KR:
        return 'assets/icons/ic_cl_bleach_kr.svg';
      default:
        return '';
    }
  }
}
