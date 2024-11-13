/*import 'package:flutter/material.dart';

class AnuncioCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String referenciaImagem;

  const AnuncioCard({
    required this.title,
    required this.description,
    required this.date,
    required this.referenciaImagem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do anúncio
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                referenciaImagem,  // URL da imagem
                width: double.infinity,  // Faz a imagem ocupar toda a largura
                height: 200,  // Altura fixa para a imagem
                fit: BoxFit.cover,  // Como a imagem deve se ajustar no espaço
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 8.0),
            // Título do anúncio
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8.0),
            // Descrição do anúncio
            Text(description),
            SizedBox(height: 8.0),
            // Data do anúncio
            Text(date, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}*/
