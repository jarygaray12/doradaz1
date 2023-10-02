import 'package:flutter/material.dart';

// Define los nuevos colores según tu solicitud
final redColor = Colors.red;
final yellowColor = Colors.yellow;
final whiteColor = Colors.white;

// Puedes mantener los otros colores si los necesitas

// Define las funciones para convertir colores hexadecimales si es necesario
Color hexStringColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
