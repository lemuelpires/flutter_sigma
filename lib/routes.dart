import 'package:flutter/material.dart';
import 'package:flutter_sigma/screens/ambienteAdministrador/ambiente_administrador_screen.dart';
import 'package:flutter_sigma/screens/auth/login_screen.dart'; // Importe a tela de login
import 'package:flutter_sigma/screens/auth/register_screen.dart'; // Importe a tela de registro
/*import 'package:flutter_sigma/screens/cadastroAnuncio/cadastro_anuncio_screen.dart';*/
import 'package:flutter_sigma/screens/cadastroProduto/cadastro_produto_screen.dart';
/*import 'package:flutter_sigma/screens/edicaoAnuncio/edicao_anuncio_screen.dart';*/
import 'package:flutter_sigma/screens/home/home_screen.dart'; // Importe a tela inicial
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
      /* '/cadastro_anuncio': (context) => CadastroAnuncio(),*/
       /*'/editar_anuncio': (context) => EditarAnuncio(),*/

    };
  }
}

