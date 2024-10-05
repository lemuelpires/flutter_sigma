/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sigma/screens/auth/login_screen.dart';
import 'package:flutter_sigma/screens/home/home_screen.dart';
import 'package:flutter_sigma/screens/splash/splash.dart'; // Importa a tela Splash
import 'firebase_options.dart'; // Certifique-se de importar o arquivo correto

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicialize o Firebase com as opções adequadas para a plataforma atual
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const SigmaApp());
}

class SigmaApp extends StatelessWidget {
  const SigmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sigma Hardware',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF101419), // Cor de fundo do AppBar (Header)
          iconTheme: IconThemeData(color: Colors.white),
          toolbarTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        // Definindo o tema principal do aplicativo
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7FFF00), // Cor principal do aplicativo
          primary: const Color(0xFF101419),
          secondary: const Color(0xFF7FFF00),
        ),
      ),
      // Defina as rotas da aplicação
      initialRoute: '/', // Inicie com a SplashScreen
      routes: {
        '/': (context) => const SplashScreen(), // Defina o SplashScreen como a primeira rota
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(), // Adiciona a rota da HomeScreen
      },
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sigma/firebase_options.dart';
import 'package:flutter_sigma/routes.dart';
import 'package:flutter_sigma/screens/utils/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SigmaApp());
}

class SigmaApp extends StatelessWidget {
  const SigmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sigma Hardware',
      theme: AppTheme.buildTheme(), // Chamada para a classe de tema
      initialRoute: '/',
      routes: AppRoutes.buildRoutes(), // Chamada para a classe de rotas
    );
  }
}
