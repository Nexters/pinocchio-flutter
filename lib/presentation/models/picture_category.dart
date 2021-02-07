enum PictureCategory { TOP, PANTS, SOCKS, UNDERWEAR, TOWEL }

extension ParseToString on PictureCategory {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String getUIValue() {
    switch (this) {
      case PictureCategory.TOP:
        return '상의';
      case PictureCategory.PANTS:
        return '하의';
      case PictureCategory.SOCKS:
        return '양말';
      case PictureCategory.UNDERWEAR:
        return '속옷';
      case PictureCategory.TOWEL:
        return '수건';
      default:
        return "";
    }
  }
}
