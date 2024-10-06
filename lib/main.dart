import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sigma/firebase_options.dart';
import 'package:flutter_sigma/routes.dart';
import 'package:flutter_sigma/screens/utils/theme.dart';
import 'package:provider/provider.dart'; // Importar o Provider
import 'package:flutter_sigma/providers/produto_providers.dart'; // Importar o ProductProvider
import 'package:flutter_sigma/repositories/produto_repositories.dart'; // Importar o ProductRepository
import 'package:flutter_sigma/api/api_cliente.dart'; // Importar o ApiClient

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
    final apiClient = ApiClient(); // Instanciar o ApiClient

    return ChangeNotifierProvider(
      create: (context) => ProductProvider(ProductRepository(apiClient)), // Passar o ApiClient para o ProductRepository
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sigma Hardware',
        theme: AppTheme.buildTheme(), // Chamada para a classe de tema
        initialRoute: '/',
        routes: AppRoutes.buildRoutes(), // Chamada para a classe de rotas
      ),
    );
  }
}
