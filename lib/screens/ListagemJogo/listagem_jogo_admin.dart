import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/providers/jogo_providers.dart';
import 'package:flutter_sigma/screens/cadastroJogo/cadastro_jogo_screen.dart';
import 'package:flutter_sigma/widgets/jogo_card.dart';
import 'package:provider/provider.dart';

class ListagemJogosPage extends StatefulWidget {
  const ListagemJogosPage({super.key});

  @override
  ListagemJogosPageState createState() => ListagemJogosPageState();
}

class ListagemJogosPageState extends State<ListagemJogosPage> {
  late JogoProvider _jogoProvider;
  bool _isDataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      _jogoProvider = Provider.of<JogoProvider>(context, listen: false);
      Future.delayed(Duration.zero, () {
        _jogoProvider.fetchJogos();
        _isDataLoaded = true;
      });
    }
  }

  Future<void> _confirmDisableJogo(BuildContext context, int idJogo) async {
    final provider = Provider.of<JogoProvider>(context, listen: false);
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
      await provider.disableJogo(idJogo);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jogo excluído com sucesso')),
      );
      provider.fetchJogos();
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
              const SizedBox(height: 40),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) {
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
              const SizedBox(height: 10),
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
                          onDisable: () async {
                            await _confirmDisableJogo(
                                context, jogosAtivos[index].idJogo!);
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
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroJogo(),
            ),
          );
        },
        backgroundColor: const Color(0xFF66CC00),
        child: const Icon(Icons.add),
      ),
    );
  }
}
