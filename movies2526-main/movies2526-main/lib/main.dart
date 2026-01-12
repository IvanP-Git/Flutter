// ignore_for_file: deprecated_member_use
// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies/screens/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { // Widget principal de la aplicación
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( // Configuración de la barra de estado
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF242A32),
      ),
    );
    return GetMaterialApp( // Uso de GetMaterialApp para gestión de rutas y estado
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF242A32),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      home: Main(), // Pantalla principal de la aplicación
    );
  }
}
