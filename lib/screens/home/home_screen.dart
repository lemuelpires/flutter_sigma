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
  bool _isHovered = false;

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
        preferredSize: Size.fromHeight(80), // Ajustando a altura do header para 80
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
              _buildPromotionAd(),
              const SizedBox(height: 20),
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
        height: MediaQuery.of(context).size.height * 0.3, // Ajustando para altura dinâmica
        autoPlay: true,
        enlargeCenterPage: true, // Itens do centro serão ampliados
        enableInfiniteScroll: true, // Permite rotação infinita
        viewportFraction: 0.8, // Ajustando a fração da área que o item ocupa
        initialPage: 0, // Começando na primeira página
      ),
      items: anuncios.map((anuncio) {
        return Builder(
          builder: (BuildContext context) {
            return Center( // Centraliza o carrossel
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9, // Controlando o tamanho dos itens
                child: AnuncioCarrosselCard(
                  anuncio: anuncio,
                  onDelete: () {
                    // Lógica para excluir o anúncio (caso necessário)
                  },
                ),
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
        height: MediaQuery.of(context).size.height * 0.4, // Altura dinâmica ajustada
        autoPlay: true,
        enlargeCenterPage: true, // Itens do centro ampliados
        enableInfiniteScroll: true, // Permite rotação infinita
        viewportFraction: 0.75, // Ajuste a fração do viewport para que os itens se encaixem melhor
        initialPage: 0, // Começando pela primeira página
        aspectRatio: 1.0, // Proporção do carrossel para garantir o ajuste
      ),
      items: produtos.map((product) {
        return Builder(
          builder: (BuildContext context) {
            return Center( // Centraliza o carrossel
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0), // Espaçamento entre os itens
                child: ProdutoCarrosselCard(
                  product: product,
                  onDetailsPressed: () {
                    // Ação para abrir os detalhes do produto
                  },
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildPromotionAd() {
    return Column(
      children: [
        Text(
          'Monte seu setup gamer agora mesmo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black54,
                offset: Offset(2, 2),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/em_construcao');
          },
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/imagemSetupGamer.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: _isHovered
                    ? [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 4))]
                    : [],
              ),
              height: _isHovered ? 130 : 120, // Ajuste a altura conforme necessário
              child: Container(
                color: Colors.black.withOpacity(0.5), // Fundo semitransparente
              ),
            ),
          ),
        ),
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