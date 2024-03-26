import 'package:flutter/material.dart';

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

// Green color code: FF93cd48
const MaterialColor lightBlack = MaterialColor(
    0xFF363636,
    {
      50: Color.fromRGBO(36, 36, 36, .1),
      100: Color.fromRGBO(36, 36, 36, .2),
      200: Color.fromRGBO(36, 36, 36, .3),
      300: Color.fromRGBO(36, 36, 36, .4),
      400: Color.fromRGBO(36, 36, 36, .5),
      500: Color.fromRGBO(36, 36, 36, .6),
      600: Color.fromRGBO(36, 36, 36, .7),
      700: Color.fromRGBO(36, 36, 36, .8),
      800: Color.fromRGBO(36, 36, 36, .9),
      900: Color.fromRGBO(36, 36, 36, 1),
    },
);

const Color lightBackground = Color.fromRGBO(235, 235, 242, 1);

const Color lightSecond = Color.fromRGBO(244, 244, 244, 1);

const Color darkBackground = Color.fromRGBO(36, 36, 36, 1);

const List<MaterialColor> themeColors = [
  Colors.orange,
  Colors.red,
  Colors.blue,
];

// const Map<String, MaterialColor> themeColors = {
//   "Orange": Colors.orange,
//   "Red": Colors.red,
//   "Blue": Colors.blue,
// };