import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sigma/firebase_options.dart';
import 'package:flutter_sigma/providers/anuncio_providers.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/providers/usuario_providers.dart';
import 'package:flutter_sigma/providers/jogo_providers.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/repositories/jogo_repositories.dart';
import 'package:flutter_sigma/repositories/produto_repositories.dart';
import 'package:flutter_sigma/repositories/anuncio_repositories.dart';
import 'package:flutter_sigma/repositories/usuario_repositories.dart';
import 'package:flutter_sigma/screens/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sigma/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Singleton do ApiClient
    final apiClient = ApiClient();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(ProductRepository(apiClient)),
        ),
        ChangeNotifierProvider(
          create: (_) => AnuncioProvider(AnuncioRepository(apiClient)),
        ),
        ChangeNotifierProvider(
          create: (_) => UsuarioProvider(UsuarioRepository(apiClient)),
        ),
        ChangeNotifierProvider(
          create: (_) => JogoProvider(JogoRepository(apiClient)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Sigma',
        theme: AppTheme.buildTheme(),
        initialRoute: '/',
        routes: AppRoutes.buildRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
