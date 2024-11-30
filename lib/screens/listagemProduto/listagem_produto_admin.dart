import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/screens/cadastroProduto/cadastro_produto_screen.dart';
import 'package:provider/provider.dart';

class ListaProdutos extends StatelessWidget {
  const ListaProdutos({super.key});

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CadastroProduto()),
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
                    context.read<ProductProvider>().filterProducts(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'Pesquisar...',
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
                child: Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.errorMessage != null) {
                      return Center(
                        child: Text(
                          provider.errorMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: provider
                          .filteredProducts.length, // Usando a lista filtrada
                      itemBuilder: (context, index) {
                        return ItemCard(
                            product: provider.filteredProducts[index]);
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

class ItemCard extends StatelessWidget {
  final Product product;

  const ItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
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
                image: NetworkImage(product.imagemProduto),
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
                  product.nomeProduto,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Estoque: ${product.quantidadeEstoque}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {
                  // Implementar funcionalidade de excluir item
                },
              ),
              const SizedBox(height: 5),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/editar_produto',
                    arguments: product,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
