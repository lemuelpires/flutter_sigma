import 'package:flutter/material.dart';
import 'package:flutter_sigma/screens/ambienteAdministrador/ambiente_administrador_screen.dart';
import 'package:flutter_sigma/screens/auth/login_screen.dart';
import 'package:flutter_sigma/screens/auth/register_screen.dart';
import 'package:flutter_sigma/screens/cadastroProduto/cadastro_produto_screen.dart';
import 'package:flutter_sigma/screens/home/home_screen.dart';
import 'package:flutter_sigma/screens/listagemProduto/listagem_produto_admin.dart';
import 'package:flutter_sigma/screens/listagemUsuario/listagem_usuario_admin.dart';
import 'package:flutter_sigma/screens/listagemAnuncio/listagem_anuncio_admin.dart';
import 'package:flutter_sigma/screens/splash/splash.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      '/': (context) => const SplashScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegistroScreen(),
      '/home': (context) => const HomeScreen(),
      '/ambiente_administrador': (context) => const AmbienteAdministrador(),
      '/lista_produtos': (context) => ListaProdutos(),
      '/lista_usuarios': (context) => ListaUsuarios(),
      '/lista_anuncios': (context) => ListaAnuncios(),
      '/cadastro_produto': (context) => CadastroProduto(),
      // Adicione novas rotas conforme necessário
    };
  }
}
