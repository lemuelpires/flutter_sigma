import 'package:flutter/material.dart';
import 'package:flutter_sigma/screens/ambienteAdministrador/ambiente_administrador_screen.dart';
import 'package:flutter_sigma/screens/auth/login_screen.dart'; // Importe a tela de login
import 'package:flutter_sigma/screens/auth/register_screen.dart'; // Importe a tela de registro
import 'package:flutter_sigma/screens/home/home_screen.dart'; // Importe a tela inicial
import 'package:flutter_sigma/screens/splash/splash.dart';
import 'package:flutter_sigma/teste_Cadastro.dart'; // Importe a tela de splash


class AppRoutes {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      '/': (context) => const SplashScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegistroScreen(),
      '/home': (context) => const HomeScreen(),
      '/ambiente_administrador': (context) => const AmbienteAdministradorScreen(),
      '/teste_cadastro': (context) => TesteCadastro(),

    };
  }
}

