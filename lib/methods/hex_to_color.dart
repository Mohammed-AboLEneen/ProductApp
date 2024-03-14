import 'package:flutter/material.dart';

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  print('hexString 0xFF$hexString');

  if (hexString.startsWith('#') == false) {
    hexString = '0xff$hexString';
  } else {
    print(hexString);
    hexString = hexString.replaceFirst('#', '0x$alphaChannel');
    print(hexString);
  }
  return Color(int.parse(
    hexString,
  ));
}
