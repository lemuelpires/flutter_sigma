/*import 'package:flutter/material.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';

class ListaProdutos extends StatelessWidget {
  const ListaProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Define a altura do header
        child: CustomHeader(title: 'header',), // Usa o seu componente de header
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    // Implementar funcionalidade de adicionar item
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Quantidade de itens
              itemBuilder: (context, index) {
                return ItemCard();
              },
            ),
          ),
          Footer(), // Usa o componente de footer
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
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
                image: NetworkImage('https://via.placeholder.com/50'), // Imagem de exemplo
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notebook Acer Nitro 5 - Core i9 - 1TB de armazenamento',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Estoque: 2',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implementar funcionalidade de excluir item
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text('Excluir', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  // Implementar funcionalidade de editar item
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text('Editar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_sigma/api/api_cliente.dart'; // Importe o ApiClient
import 'package:flutter_sigma/models/produto_model.dart'; // Importe o modelo Produto
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/repositories/produto_repositories.dart'; // Importe o repositório
import 'package:flutter_sigma/widgets/footer.dart'; // Importe o Footer
import 'package:flutter_sigma/widgets/header.dart'; // Importe o Header
import 'package:provider/provider.dart'; // Importe o Provider

class ListaProdutos extends StatelessWidget {
  const ListaProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Define a altura do header
        child: CustomHeader(title: 'Produtos',), // Usa o seu componente de header
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    // Implementar funcionalidade de adicionar item
                  },
                ),
              ],
            ),
          ),
          // Usando o Consumer para escutar mudanças no ProductProvider
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.errorMessage != null) {
                  return Center(child: Text(provider.errorMessage!));
                }

                return ListView.builder(
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    return ItemCard(product: provider.products[index]);
                  },
                );
              },
            ),
          ),
          Footer(), // Usa o componente de footer
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
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
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
                image: NetworkImage(product.imagemProduto), // Usando a imagem do produto
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.nomeProduto,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Estoque: ${product.quantidadeEstoque}',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implementar funcionalidade de excluir item
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text('Excluir', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  // Implementar funcionalidade de editar item
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text('Editar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Dentro do main.dart, faça a injeção de dependência do ProductProvider
void main() {
  final apiClient = ApiClient();
  final productRepository = ProductRepository(apiClient);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductProvider(productRepository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sigma',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ListaProdutos(),
    );
  }
}

