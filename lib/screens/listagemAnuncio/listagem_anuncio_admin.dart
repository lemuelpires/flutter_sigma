import 'package:flutter/material.dart';
import 'package:flutter_sigma/providers/anuncio_providers.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';
import 'package:flutter_sigma/widgets/anuncio_card.dart'; // Importando AnuncioCard
import 'package:provider/provider.dart';

class ListaAnuncios extends StatefulWidget {
  const ListaAnuncios({super.key});

  @override
  _ListaAnunciosState createState() => _ListaAnunciosState();
}

class _ListaAnunciosState extends State<ListaAnuncios> {
  @override
  void initState() {
    super.initState();
    // Carregar os anúncios assim que a tela for montada
    Provider.of<AnuncioProvider>(context, listen: false).loadAnuncios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomHeader(title: 'Anúncios'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Adicionar Anúncio',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    // Implementar funcionalidade de adicionar anúncio
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<AnuncioProvider>(
              builder: (context, anuncioProvider, _) {
                return anuncioProvider.anuncios.isEmpty
                    ? Center(child: CircularProgressIndicator()) // Esperando os dados
                    : ListView.builder(
                        itemCount: anuncioProvider.anuncios.length,
                        itemBuilder: (context, index) {
                          final anuncio = anuncioProvider.anuncios[index];
                          return AnuncioCard(
                            title: anuncio.titulo,
                            description: anuncio.descricao,
                            date: 'Data: ${anuncio.data.toLocal().toString().split(' ')[0]}',
                            referenciaImagem: anuncio.referenciaImagem, // Passando a URL da imagem
                          );
                        },
                      );
              },
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}
