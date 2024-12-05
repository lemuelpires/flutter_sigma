import 'package:carousel_slider/carousel_slider.dart' as custom_carousel;
import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/screens/home/home_listagem_screen.dart';
import 'package:flutter_sigma/widgets/anuncio_carrossel_card.dart';
import 'package:flutter_sigma/widgets/header.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/models/anuncio_model.dart'; 
import 'package:flutter_sigma/providers/anuncio_providers.dart';
import 'package:flutter_sigma/widgets/produto_carrossel_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AnuncioProvider>(context, listen: false).loadAnuncios();
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  void _onSearch(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeListagemScreen(searchQuery: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final anuncioProvider = Provider.of<AnuncioProvider>(context);
    final produtoProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomHeader(title: 'header', onSearch: _onSearch),
      ),
      backgroundColor: const Color(0xFF101419),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnuncioCarousel(anuncioProvider.anuncios),
              const SizedBox(height: 20),
              _buildSectionTitle('Mais Vendidos'),
              const SizedBox(height: 10),
              _buildFeaturedProductsCarousel(produtoProvider.products),
              const SizedBox(height: 20),
              _buildSectionTitle('Categorias'),
              const SizedBox(height: 10),
              _buildCategories(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildAnuncioCarousel(List<Anuncio> anuncios) {
    return custom_carousel.CarouselSlider(
      options: custom_carousel.CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: anuncios.map((anuncio) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,              
              child: AnuncioCarrosselCard(
                anuncio: anuncio,
                onDelete: () {
                  // Lógica para excluir o anúncio (caso necessário)
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFeaturedProductsCarousel(List<Product> produtos) {
    return custom_carousel.CarouselSlider(
      options: custom_carousel.CarouselOptions(
        height: 400,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: produtos.map((product) {
        return Builder(
          builder: (BuildContext context) {
            return ProdutoCarrosselCard(
              product: product,
              onDetailsPressed: () {
                // Ação para abrir os detalhes do produto
              },
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CategoryWidget(title: 'Eletrônicos'),
        CategoryWidget(title: 'Roupas'),
        CategoryWidget(title: 'Alimentos'),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String title;

  const CategoryWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.category, size: 40, color: Colors.white),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}