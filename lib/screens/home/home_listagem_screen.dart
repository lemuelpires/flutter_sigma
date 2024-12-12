import 'package:flutter/material.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';
import 'package:flutter_sigma/widgets/produto_listagem_card.dart';
import 'package:provider/provider.dart';

class HomeListagemScreen extends StatefulWidget {
  final String searchQuery;

  const HomeListagemScreen({super.key, required this.searchQuery});

  @override
  HomeListagemScreenState createState() => HomeListagemScreenState();
}

class HomeListagemScreenState extends State<HomeListagemScreen> {
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.searchQuery;
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts()
            .then((_) {
          if (_searchQuery.isNotEmpty) {
            context.read<ProductProvider>().filterProducts(_searchQuery);
          }
        });
      }
    });
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    context.read<ProductProvider>().filterProducts(query);
  }

  void _onFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filtrar por Preço',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Maior Valor'),
                onTap: () {
                  context
                      .read<ProductProvider>()
                      .sortProductsByPrice(descending: true);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Menor Valor'),
                onTap: () {
                  context
                      .read<ProductProvider>()
                      .sortProductsByPrice(descending: false);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
              CustomHeader(title: 'Home', onSearch: _onSearch),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Resultados para: "$_searchQuery"',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onPressed: _onFilter,
                    ),
                  ],
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

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: provider.filteredProducts.length,
                      itemBuilder: (context, index) {
                        return AnimatedItem(
                          child: ProdutoListagemCard(
                            product: provider.filteredProducts[index],
                            onDetails: () {
                              Navigator.pushNamed(
                                context,
                                '/produto',
                                arguments: provider.filteredProducts[index]
                                    .idProduto, // Certifique-se que `idProduto` é String
                              );
                            },
                          ),
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
      bottomNavigationBar: const Footer(),
    );
  }
}

class AnimatedItem extends StatefulWidget {
  final Widget child;

  const AnimatedItem({super.key, required this.child});

  @override
  AnimatedItemState createState() => AnimatedItemState();
}

class AnimatedItemState extends State<AnimatedItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered ? Matrix4.translationValues(0, -10, 0) : Matrix4.identity(),
        child: widget.child,
      ),
    );
  }
}