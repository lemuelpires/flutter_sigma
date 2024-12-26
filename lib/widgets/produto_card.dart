import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/produto_model.dart';

class ProdutoCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDisable;
  final Function(Product) onEdit;

  const ProdutoCard({
    super.key,
    required this.product,
    required this.onDisable,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withAlpha((0.1 * 255).toInt()),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imagemProduto),
          radius: 30,
          onBackgroundImageError: (exception, stackTrace) {
            // Gerenciar erros de carregamento de imagem
          },
        ),
        title: Text(
          product.nomeProduto,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'Estoque: ${product.quantidadeEstoque}',
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.yellow,
              ),
              onPressed: () async {
                final updatedProduct = await Navigator.pushNamed(
                  context,
                  '/editar_produto',
                  arguments: product,
                ) as Product?;
                if (updatedProduct != null) {
                  onEdit(updatedProduct);
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDisable,
            ),
          ],
        ),
      ),
    );
  }
}