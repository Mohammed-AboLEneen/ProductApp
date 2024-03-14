import 'package:flutter/material.dart';

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  if (hexString.startsWith('#') == false) {
    hexString = '0xff$hexString';
  } else {
    hexString = hexString.replaceFirst('#', '0x$alphaChannel');
  }
  return Color(int.parse(
    hexString,
  ));
}
