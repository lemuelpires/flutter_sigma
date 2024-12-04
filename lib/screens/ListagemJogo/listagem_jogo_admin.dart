import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/providers/jogo_providers.dart';
import 'package:flutter_sigma/widgets/jogo_card.dart';  // Importando o JogoCard
import 'package:provider/provider.dart';

class ListagemJogosPage extends StatefulWidget {
  const ListagemJogosPage({super.key});

  @override
  ListagemJogosPageState createState() => ListagemJogosPageState();
}

class ListagemJogosPageState extends State<ListagemJogosPage> {
  late JogoProvider _jogoProvider;
  bool _isDataLoaded = false; // Controle para evitar recarregar dados várias vezes

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      _jogoProvider = Provider.of<JogoProvider>(context, listen: false);

      // Usar Future.delayed para adiar a chamada após a conclusão do ciclo de construção
      Future.delayed(Duration.zero, () {
        _jogoProvider.fetchJogos();
        _isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Column(
            children: [
              const SizedBox(height: 40), // Adiciona espaço no início da página
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
                            Navigator.pushNamed(
                              context,
                              '/cadastro_jogo',
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Campo de pesquisa
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) {
                    // Chama o método de filtro no Provider para realizar a pesquisa
                    context.read<JogoProvider>().filterJogos(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'Pesquisar jogos...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Espaço após o campo de pesquisa
              Expanded(
                child: Consumer<JogoProvider>(
                  builder: (context, jogoProvider, child) {
                    if (jogoProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (jogoProvider.errorMessage != null) {
                      return Center(
                        child: Text(
                          jogoProvider.errorMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    // Filtrando apenas jogos ativos na listagem
                    final jogosAtivos = jogoProvider.filteredJogos
                        .where((jogo) => jogo.ativo == true)
                        .toList();

                    if (jogosAtivos.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum jogo ativo encontrado.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: jogosAtivos.length,
                      itemBuilder: (context, index) {
                        return JogoCard(
                          jogo: jogosAtivos[index],
                          onEdit: () async {
                            final updatedJogo = await Navigator.pushNamed(
                              context,
                              '/editar_jogo',
                              arguments: jogosAtivos[index],
                            ) as Jogo?;
                            if (updatedJogo != null) {
                              jogoProvider.updateJogoInList(updatedJogo);
                            }
                          },
                          onDelete: () async {
                            await jogoProvider.deleteJogo(
                                jogosAtivos[index].idJogo!);
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