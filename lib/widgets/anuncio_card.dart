import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';

class AnuncioCard extends StatelessWidget {
  final Anuncio anuncio;
  final VoidCallback onDelete;

  const AnuncioCard({
    super.key,
    required this.anuncio,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white.withOpacity(0.1),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(anuncio.referenciaImagem),
          radius: 30,
          onBackgroundImageError: (exception, stackTrace) {
            // Se houver erro na imagem, exibe uma imagem padrão
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
          'R\$ ${anuncio.preco.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
