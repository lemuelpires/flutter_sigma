import 'package:flutter/material.dart';
import 'package:flutter_sigma/providers/anuncio_providers.dart';
import 'package:flutter_sigma/screens/cadastroAnuncio/cadastro_anuncio_screen.dart';
import 'package:provider/provider.dart';

class ListaAnuncios extends StatefulWidget {
  const ListaAnuncios({super.key});

  @override
  ListaAnunciosState createState() => ListaAnunciosState();
}

class ListaAnunciosState extends State<ListaAnuncios> {
 @override
void initState() {
  super.initState();
  // Carrega os jogos quando a tela for inicializada
  Future.delayed(Duration.zero, () {
    if (mounted) {
      Provider.of<AnuncioProvider>(context, listen: false).loadAnuncios();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Ícone de seta para voltar
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela anterior
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Lista de Anúncios",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Consumer<AnuncioProvider>(
                    builder: (context, anuncioProvider, child) {
                      if (anuncioProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (anuncioProvider.errorMessage != null) {
                        return Center(
                          child: Text(
                            anuncioProvider.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (anuncioProvider.anuncios.isEmpty) {
                        return const Center(
                          child: Text(
                            'Nenhum anúncio disponível.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: anuncioProvider.anuncios.length,
                        itemBuilder: (context, index) {
                          final anuncio = anuncioProvider.anuncios[index];

                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            color: Colors.white.withOpacity(0.1),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  anuncio.referenciaImagem, // Imagem do anúncio
                                ),
                                radius: 30,
                                onBackgroundImageError: (exception, stackTrace) {
                                  // Caso a imagem não carregue, exibe uma imagem de fallback
                                  setState(() {
                                    anuncio.referenciaImagem = 'url_da_imagem_fallback';
                                  });
                                },
                              ),
                              title: Text(
                                anuncio.titulo,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '\$${anuncio.preco}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  await anuncioProvider.deleteAnuncio(anuncio.idAnuncio!);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7FFF00), Color(0xFF66CC00)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navegar para a tela de adicionar anúncio
                          // Substitua 'AddAnuncioScreen' pelo nome da sua tela de adição de anúncio
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CadastroAnuncio()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Adicionar Anúncio',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
