/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sigma/firebase_options.dart';
import 'package:flutter_sigma/routes.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/repositories/produto_repositories.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final apiClient = ApiClient(); // Inicializar ApiClient
            final productRepository =
                ProductRepository(apiClient); // Inicializar ProductRepository
            return ProductProvider(
                productRepository); // Inicializar ProductProvider
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Sigma',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
        ),
        initialRoute: '/', // Definir a rota inicial
        routes: AppRoutes.buildRoutes(), // Usar as rotas definidas
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sigma/firebase_options.dart';
import 'package:flutter_sigma/routes.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/repositories/produto_repositories.dart';
import 'package:flutter_sigma/screens/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final apiClient = ApiClient(); // Inicializar ApiClient
            final productRepository = ProductRepository(apiClient); // Inicializar ProductRepository
            return ProductProvider(productRepository); // Inicializar ProductProvider
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Sigma',
        theme: AppTheme.buildTheme(), // Aplicar o tema personalizado
        initialRoute: '/', // Definir a rota inicial
        routes: AppRoutes.buildRoutes(), // Usar as rotas definidas
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

