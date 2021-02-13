import 'package:flutter/material.dart';

enum ClothesColorType {
  RED,
  ORANGE,
  YELLOW,
  GREEN,
  BLUE,
  PURPLE,
  BEIGE,
  WHITE,
  GREY,
  BLACK
}

class ClothesColor {
  Color _unSelectedColor;
  Color _selectedColor;
  Color _borderColor;

  ClothesColor({unSelectedColor, selectedColor, borderColor}) {
    this._unSelectedColor = unSelectedColor;
    this._selectedColor = selectedColor;
    this._borderColor = borderColor;
  }

  Color get borderColor => _borderColor;

  Color get selectedColor => _selectedColor;

  Color get unSelectedColor => _unSelectedColor;
}

extension ParseToString on ClothesColorType {
  String toShortString() {
    return this.toString().split('.').last;
  }

  ClothesColor getColorWidget() {
    switch (this) {
      case ClothesColorType.RED:
        return ClothesColor(
            unSelectedColor: Color(0xFFF54343),
            selectedColor: Color(0xFFD31717),
            borderColor: Color(0xFFE61E1E));
      case ClothesColorType.ORANGE:
        return ClothesColor(
            unSelectedColor: Color(0xFFFBA951),
            selectedColor: Color(0xFFEC8313),
            borderColor: Color(0xFFEF902A));
      case ClothesColorType.YELLOW:
        return ClothesColor(
            unSelectedColor: Color(0xFFFBE96A),
            selectedColor: Color(0xFFE9D62B),
            borderColor: Color(0xFFF0DA42));
      case ClothesColorType.GREEN:
        return ClothesColor(
            unSelectedColor: Color(0xFF3DAC51),
            selectedColor: Color(0xFF316D3C),
            borderColor: Color(0xFF397F45));
      case ClothesColorType.BLUE:
        return ClothesColor(
            unSelectedColor: Color(0xFF288BE0),
            selectedColor: Color(0xFF21639C),
            borderColor: Color(0xFF2570B1));
      case ClothesColorType.PURPLE:
        return ClothesColor(
            unSelectedColor: Color(0xFF8B62F3),
            selectedColor: Color(0xFF5628E2),
            borderColor: Color(0xFF673EE5));
      case ClothesColorType.BEIGE:
        return ClothesColor(
            unSelectedColor: Color(0xFFEADFCF),
            selectedColor: Color(0xFFCBB99F),
            borderColor: Color(0xFFD4C5B0));
      case ClothesColorType.WHITE:
        return ClothesColor(
            unSelectedColor: Color(0xFFFFFFFF),
            selectedColor: Color(0xFFDBDBDB),
            borderColor: Color(0xFFD9D9D9));
      case ClothesColorType.GREY:
        return ClothesColor(
            unSelectedColor: Color(0xFFBEBEBE),
            selectedColor: Color(0xFF999999),
            borderColor: Color(0xFFA6A6A6));
      case ClothesColorType.BLACK:
        return ClothesColor(
            unSelectedColor: Color(0xFF383838),
            selectedColor: Color(0xFF000000),
            borderColor: Color(0xFF000000));
      default:
        return ClothesColor(
            unSelectedColor: Color(0xFFFFFFFF),
            selectedColor: Color(0xFFDBDBDB),
            borderColor: Color(0xFFD9D9D9));
    }
  }
}
