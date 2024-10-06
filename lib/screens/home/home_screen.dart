// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_sigma/widgets/header.dart';
import 'package:flutter_sigma/widgets/footer.dart'; // Importando o Footer
import 'package:flutter_sigma/models/produto_model.dart'; // Importar o modelo
import 'package:flutter_sigma/providers/produto_providers.dart'; // Importar o ProductProvider
import 'package:provider/provider.dart'; // Importar o provider

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState(); // Modificado
}

class HomeScreenState extends State<HomeScreen> { // Modificado
  @override
  void initState() {
    super.initState();
    // Carregar produtos quando a tela é inicializada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60), // Altura do AppBar (Header)
        child: CustomHeader(), // Usando o Header customizado
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: productProvider.isLoading
            ? const Center(child: CircularProgressIndicator()) // Indicador de carregamento
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Carrossel de Produtos em Destaque
                    _buildFeaturedProductsCarousel(productProvider.products),
                    const SizedBox(height: 20),

                    // Título de Categorias
                    _buildSectionTitle('Categorias'),
                    const SizedBox(height: 10),
                    _buildCategories(),
                    const SizedBox(height: 20),

                    // Título de Novidades
                    _buildSectionTitle('Novidades'),
                    const SizedBox(height: 10),
                    _buildNewProducts(productProvider.products),
                    const SizedBox(height: 20),

                    // Título de Ofertas
                    _buildSectionTitle('Ofertas Especiais'),
                    const SizedBox(height: 10),
                    _buildSpecialOffers(productProvider.products),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: const Footer(), // Corrigido o posicionamento do Footer
    );
  }


  Widget _buildFeaturedProductsCarousel(List<Product> products) {
    return Container(
      height: 200,
      color: Colors.grey[850],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length, // Usar o número de produtos carregados
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(product.imagemProduto), // Usar a imagem do produto
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80), // Espaço para imagem
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.nomeProduto, // Usar o nome do produto
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'R\$ ${product.preco.toStringAsFixed(2)}', // Usar o preço do produto
                    style: const TextStyle(color: Colors.yellowAccent),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategoryItem('Jogos', Icons.videogame_asset),
        _buildCategoryItem('Consoles', Icons.gamepad),
        _buildCategoryItem('Acessórios', Icons.headset),
      ],
    );
  }

  Widget _buildCategoryItem(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[800],
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildNewProducts(List<Product> products) {
    return Container(
      height: 100,
      color: Colors.grey[850],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length, // Usar o número de produtos
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(product.imagemProduto), // Usar a imagem do produto
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60), // Espaço para imagem
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    product.nomeProduto, // Usar o nome do produto
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpecialOffers(List<Product> products) {
    return Container(
      height: 100,
      color: Colors.grey[850],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length, // Usar o número de produtos
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(product.imagemProduto), // Usar a imagem do produto
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60), // Espaço para imagem
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    product.nomeProduto, // Usar o nome do produto
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
