import 'package:flutter/material.dart';
import 'search.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controlador de animación para el progreso

  @override
  void initState() {
    super.initState();

    _controller = AnimationController( // Inicializa el controlador de animación
      vsync: this,
      duration: const Duration(seconds: 5), // Duración de la animación (5 segundos)
    )..forward();

    Future.delayed(const Duration(seconds: 5), () { // Después de 5 segundos, navega a la pantalla de búsqueda
      if (!mounted) return;
      Navigator.pushReplacement( // Reemplaza la pantalla actual con la pantalla de búsqueda
          context, MaterialPageRoute(builder: (_) => const Search())); // Navega a la pantalla de búsqueda
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ // Contenido del splash screen
              Text(
                'Splash',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Image.asset( // Logo de la aplicación
                'assets/logo.png',
                width: 350,
                height: 350,
              ),
              const SizedBox(height: 20),
              AnimatedBuilder( // Construye el indicador de progreso animado
                animation: _controller,
                builder: (context, child) {
                  return LinearProgressIndicator( // Indicador de progreso lineal que se llena a medida que avanza la animación
                    value: _controller.value,
                    backgroundColor: Colors.grey.shade700,
                    color: Colors.blueAccent,
                    minHeight: 8,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}