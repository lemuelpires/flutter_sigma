import 'package:carousel_slider/carousel_slider.dart' as custom_carousel;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_sigma/widgets/header.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
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
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomHeader(title: 'header',),
      ),
      backgroundColor: const Color(0xFF101419),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnuncioCarousel(),
              const SizedBox(height: 20),
              _buildSectionTitle('Mais Vendidos'),
              const SizedBox(height: 10),
              _buildFeaturedProductsCarousel(productProvider.products),
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

  Widget _buildAnuncioCarousel() {
    final List<String> anuncios = [
      'Anuncio 1',
      'Anuncio 2',
      'Anuncio 3',
    ];

    return custom_carousel.CarouselSlider(
      options: custom_carousel.CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: anuncios.map((anuncio) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  anuncio,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFeaturedProductsCarousel(List<Product> products) {
    return custom_carousel.CarouselSlider(
      options: custom_carousel.CarouselOptions(
        height: 300,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: products.map((product) {
        return Container(
          width: 220,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF1C1F23),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: product.imagemProduto.endsWith('.svg')
                    ? SvgPicture.network(
                        product.imagemProduto,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholderBuilder: (BuildContext context) => Container(
                          height: 120,
                          color: Colors.grey[800],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : Image.network(
                        product.imagemProduto,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 120,
                            width: double.infinity,
                            color: Colors.grey[800],
                            child: const Center(child: Icon(Icons.error, color: Colors.red)),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.nomeProduto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'R\$ ${product.preco.toStringAsFixed(2)}',
                  style: const TextStyle(color: Color(0xFF7FFF00)),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de detalhes
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7FFF00),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text(
                    'Detalhes',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
