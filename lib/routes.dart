import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/models/usuario_model.dart';  // Certifique-se de importar o modelo do usuário
import 'package:flutter_sigma/screens/ListagemJogo/listagem_jogo_admin.dart';
import 'package:flutter_sigma/screens/ambienteAdministrador/ambiente_administrador_screen.dart';
import 'package:flutter_sigma/screens/auth/login_screen.dart';
import 'package:flutter_sigma/screens/auth/register_screen.dart';
import 'package:flutter_sigma/screens/cadastroAnuncio/cadastro_anuncio_screen.dart';
import 'package:flutter_sigma/screens/cadastroJogo/cadastro_jogo_screen.dart';
import 'package:flutter_sigma/screens/cadastroProduto/cadastro_produto_screen.dart';
import 'package:flutter_sigma/screens/contato/contato_screen.dart';
import 'package:flutter_sigma/screens/edicaoAnuncio/edicao_anuncio_screen.dart';
import 'package:flutter_sigma/screens/edicaoJogo/edicao_jogo_screen.dart';
import 'package:flutter_sigma/screens/edicaoProduto/edicao_produto_screen.dart';
import 'package:flutter_sigma/screens/edicaoUsuario/edicao_usuario_screen.dart'; // Importando a tela de edição de usuário
import 'package:flutter_sigma/screens/emConstrucao/em_construcao_screen.dart';
import 'package:flutter_sigma/screens/home/home_listagem_screen.dart';
import 'package:flutter_sigma/screens/home/home_screen.dart';
import 'package:flutter_sigma/screens/lgpd/policy_privacity_screen.dart';
import 'package:flutter_sigma/screens/lgpd/terms_conditions_screen.dart';
import 'package:flutter_sigma/screens/listagemProduto/listagem_produto_admin.dart';
import 'package:flutter_sigma/screens/listagemUsuario/listagem_usuario_admin.dart';
import 'package:flutter_sigma/screens/listagemAnuncio/listagem_anuncio_admin.dart';
import 'package:flutter_sigma/screens/produto/produto_detail_screen.dart';
import 'package:flutter_sigma/screens/sobre/sobre_screen.dart';
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
      '/lista_jogos': (context) => ListagemJogosPage(),
      '/home_lista': (context) => HomeListagemScreen(searchQuery: '',),
      '/cadastro_produto': (context) => CadastroProduto(),
      '/cadastro_anuncio': (context) => CadastroAnuncio(),
      '/cadastro_jogo': (context) => CadastroJogo(),
      '/contatos': (context) => ContatosPage(),
      '/em_construcao': (context) => EmConstrucaoPage(),
      '/sobre': (context) => SobreNosPage(),
      '/termos_condicoes': (context) => TermsConditionsScreen(),
      '/politica_privacidade': (context) => PrivacyPolicyScreen(),
      '/produto': (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        if (args is int) {
          return ProdutoPage(productId: args);
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Erro: Produto não encontrado.'),
            ),
          );
        }
      },
      '/editar_anuncio': (context) {
        // Obtendo os argumentos passados para a rota
        final args = ModalRoute.of(context)?.settings.arguments;

        // Verificando se os argumentos são do tipo Anuncio
        if (args is Anuncio) {
          return EditarAnuncio(anuncio: args);
        } else {
          // Caso o argumento seja inválido, exibe um placeholder ou mensagem de erro
          return const Scaffold(
            body: Center(
              child: Text('Erro: Anúncio não encontrado.'),
            ),
          );
        }
      },
      '/editar_usuario': (context) {
        // Obtendo os argumentos passados para a rota
        final args = ModalRoute.of(context)?.settings.arguments;

        // Verificando se os argumentos são do tipo Usuario
        if (args is Usuario) {
          return EditarUsuario(usuario: args); // Passando o usuário para a tela de edição
        } else {
          // Caso o argumento seja inválido, exibe um placeholder ou mensagem de erro
          return const Scaffold(
            body: Center(
              child: Text('Erro: Usuário não encontrado.'),
            ),
          );
        }
      },
      '/editar_jogo': (context) {
        // Obtendo os argumentos passados para a rota
        final args = ModalRoute.of(context)?.settings.arguments;

        // Verificando se os argumentos são do tipo Usuario
        if (args is Jogo) {
          return EditarJogo(jogo: args); // Passando o usuário para a tela de edição
        } else {
          // Caso o argumento seja inválido, exibe um placeholder ou mensagem de erro
          return const Scaffold(
            body: Center(
              child: Text('Erro: Usuário não encontrado.'),
            ),
          );
        }
      },
      '/editar_produto': (context) {
        // Obtendo os argumentos passados para a rota
        final args = ModalRoute.of(context)?.settings.arguments;

        // Verificando se os argumentos são do tipo Usuario
        if (args is Product) {
          return EdicaoProdutoScreen(product: args); // Passando o usuário para a tela de edição
        } else {
          // Caso o argumento seja inválido, exibe um placeholder ou mensagem de erro
          return const Scaffold(
            body: Center(
              child: Text('Erro: Usuário não encontrado.'),
            ),
          );
        }
      },
      // Adicione novas rotas conforme necessário
    };
  }
}
