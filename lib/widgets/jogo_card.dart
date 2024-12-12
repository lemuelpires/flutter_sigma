import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/jogo_model.dart';

class JogoCard extends StatelessWidget {
  final Jogo jogo;
  final VoidCallback onEdit;
  final VoidCallback onDisable;

  const JogoCard({
    super.key,
    required this.jogo,
    required this.onEdit,
    required this.onDisable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(jogo.referenciaImagemJogo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jogo.nomeJogo,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Categoria: ${jogo.categoriaJogo}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
                IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.yellow,
                  size: 25,
                ),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 25,
                ),
                onPressed: onDisable,
              ),
            ],
          ),
        ],
      ),
    );
  }
}