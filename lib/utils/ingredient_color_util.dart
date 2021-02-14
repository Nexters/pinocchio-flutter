import 'package:flutter/material.dart';

class IngredientColorUtil {
  static List<Color> getIngredientColors(int size) {
    List<Color> items = [];
    for (int i = 0; i < size; i++) {
      items.add(_getIngredientColorValueFromIndex(i));
    }
    return items;
  }

  static Color _getIngredientColorValueFromIndex(int index) {
    switch (index) {
      case 0:
        return Color(0xFFFFC33A);
      case 1:
        return Color(0xFFF2AEAE);
      case 2:
        return Color(0xFF81B7F1);
      case 3:
        return Color(0xFF9E81F1);
      case 4:
        return Color(0xFF55AF74);
      default:
        return Color(0xFFFFFFFF);
    }
  }
}
