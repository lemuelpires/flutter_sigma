import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';

class AnuncioCarrosselCard extends StatelessWidget {
  final Anuncio anuncio;
  final VoidCallback onDelete;

  const AnuncioCarrosselCard({
    super.key,
    required this.anuncio,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(0, 8, 8, 8).withAlpha((1 * 255).toInt()),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
        child: Image.network(
          anuncio.referenciaImagem,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}