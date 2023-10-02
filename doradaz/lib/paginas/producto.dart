import 'dart:ui';

class Producto {
  final String nombre;
  final double precio;
  final String imagenUrl;
  final Color bordeColor;
  final Color descripcion;
  Producto({
    required this.nombre,
    required this.precio,
    required this.imagenUrl,
    required this.bordeColor,
    required this.descripcion,
  });
}
