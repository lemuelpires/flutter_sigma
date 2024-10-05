import 'package:flutter/material.dart';
import 'dart:async'; // Para usar o Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Aguarda 3 segundos antes de redirecionar para a tela de login
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login'); // Redireciona para a tela de login
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF101419), // Cor de fundo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7FFF00)), // Cor do círculo
            ),
            SizedBox(height: 16), // Espaço entre o círculo e o texto
            Text(
              'Carregando...',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
