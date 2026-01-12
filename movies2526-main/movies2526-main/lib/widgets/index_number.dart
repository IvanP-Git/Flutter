// Importaciones necesarias
import 'package:flutter/material.dart';

class IndexNumber extends StatelessWidget { // Clase IndexNumber que extiende StatelessWidget
  const IndexNumber({
    super.key,
    required this.number,
  }); // Constructor que recibe un número requerido
  final int number; // Propiedad para almacenar el número

  @override
  Widget build(BuildContext context) { // Método build que construye el widget
    return Text(
      (number).toString(), // Convierte el número a cadena y lo muestra en un Text widget
      style: const TextStyle(
        fontSize: 120,
        fontWeight: FontWeight.w600,
        shadows: [ // Define sombras para el texto
          Shadow(
            offset: Offset(-1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(-1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
        ],
        color: Color(0xFF242A32),
      ),
    );
  }
}
