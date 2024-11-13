import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/providers/jogo_providers.dart';
import 'package:provider/provider.dart';

class ListaJogos extends StatelessWidget {
  const ListaJogos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Lista de Jogos',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    // Adicionar funcionalidade de navegação para a tela de adicionar jogo
                    Navigator.pushNamed(context, '/cadastro_jogo');
                  },
                ),
              ],
            ),
          ),
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
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (jogoProvider.jogos.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum jogo disponível.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: jogoProvider.jogos.length,
                  itemBuilder: (context, index) {
                    return JogoCard(
                      jogo: jogoProvider.jogos[index],
                      onEdit: () {
                        // Navegar para a tela de edição de jogo
                        Navigator.pushNamed(
                          context,
                          '/editar-jogo',
                          arguments: jogoProvider.jogos[index],
                        );
                      },
                      onDelete: () async {
                        // Chamar o método de exclusão
                        await jogoProvider.deleteJogo(jogoProvider.jogos[index].idJogo!);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class JogoCard extends StatelessWidget {
  final Jogo jogo;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const JogoCard({
    super.key,
    required this.jogo,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(jogo.referenciaImagemJogo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jogo.nomeJogo,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Categoria: ${jogo.categoriaJogo}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            children: [
              ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text('Excluir', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: onEdit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text('Editar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
