import 'package:flutter/material.dart';
import 'package:flutter_sigma/providers/anuncio_providers.dart';
import 'package:flutter_sigma/screens/cadastroAnuncio/cadastro_anuncio_screen.dart';
import 'package:flutter_sigma/widgets/anuncio_card.dart';
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
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Provider.of<AnuncioProvider>(context, listen: false).loadAnuncios();
      }
    });
  }

  Future<void> _confirmDisableAnuncio(BuildContext context, int idAnuncio) async {
    final provider = Provider.of<AnuncioProvider>(context, listen: false);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja excluir esse cadastro?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await provider.disableAnuncio(idAnuncio);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anúncio excluído com sucesso')),
      );
      provider.loadAnuncios();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(color: Colors.black.withOpacity(0.7)),
          Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'Adicionar',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CadastroAnuncio()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) {
                    context.read<AnuncioProvider>().filterAnuncios(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'Pesquisar...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Consumer<AnuncioProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.errorMessage != null) {
                      return Center(
                        child: Text(
                          provider.errorMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: provider.filteredAnuncios.length,
                      itemBuilder: (context, index) {
                        return AnuncioCard(
                          anuncio: provider.filteredAnuncios[index],
                          onDisable: () async {
                            await _confirmDisableAnuncio(
                                context, provider.filteredAnuncios[index].idAnuncio!);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}