import 'package:flutter/material.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/screens/cadastroProduto/cadastro_produto_screen.dart';
import 'package:flutter_sigma/widgets/produto_card.dart';
import 'package:provider/provider.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  ListaProdutosState createState() => ListaProdutosState();
}

class ListaProdutosState extends State<ListaProdutos> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Provider.of<ProductProvider>(context, listen: false).fetchProducts();
      }
    });
  }

  Future<void> _confirmDisableProduto(
      BuildContext context, int idProduto) async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
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
      await provider.disableProduct(idProduto);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto excluído com sucesso')),
        );
        provider.fetchProducts();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            color: Colors.black.withAlpha((0.7 * 255).toInt()),
          ),
          Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
              const SizedBox(height: 10),
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

                    final produtosAtivos = provider.filteredProducts
                        .where((produto) => produto.ativo == true)
                        .toList();

                    if (produtosAtivos.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum produto ativo encontrado.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: produtosAtivos.length,
                      itemBuilder: (context, index) {
                        return ProdutoCard(
                          product: produtosAtivos[index],
                          onDisable: () async {
                            await _confirmDisableProduto(
                                context, produtosAtivos[index].idProduto!);
                          },
                          onEdit: (updatedProduct) {
                            provider.updateProductInList(updatedProduct);
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
              builder: (context) => CadastroProduto(),
            ),
          );
        },
        backgroundColor: const Color(0xFF66CC00),
        child: const Icon(Icons.add),
      ),
    );
  }
}
