import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/produto_model.dart'; // Importe a classe Product que você já tem

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDetailsPressed;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280, // Largura mais estreita
        height: 380, // Altura ajustada
        child: Card(
          color: Colors.black.withOpacity(0.7), // Fundo escuro
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 12),
          elevation: 6, // Sombra para destacar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.imagemProduto,
                  height: 180, // Altura ajustada para maior destaque
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nomeProduto,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.local_offer, color: Colors.greenAccent, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          'R\$ ${product.preco.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7FFF00), Color(0xFF66CC00)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: onDetailsPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Ver Detalhes',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
