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
      color: Colors.white.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(anuncio.referenciaImagem),
          radius: 30,
          onBackgroundImageError: (exception, stackTrace) {
            // Handle image error
          },
        ),
        title: Text(
          anuncio.titulo,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '\$${anuncio.preco}',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.yellow,
              ),
              onPressed: () {
                // Navigate to edit screen
                Navigator.pushNamed(
                  context,
                  '/editar_anuncio',
                  arguments: anuncio,
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}


