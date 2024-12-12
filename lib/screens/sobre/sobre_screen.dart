import 'package:flutter/material.dart';

class SobreNosPage extends StatelessWidget {
  const SobreNosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre a Sigma Hardware',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const AnimatedRow(
              icon: Icons.info,
              text: 'Sigma Hardware',
              color: Color.fromARGB(255, 241, 242, 242),
            ),
            const SizedBox(height: 16.0),
            const AnimatedText(
              text:
                  'Bem-vindo à Sigma Hardware, onde gaming e tecnologia se encontram.',
            ),
            const SizedBox(height: 24.0),
            buildCardSection(
              'Nossa Loja',
              Icons.store,
              'Especializados em produtos para gamers, oferecemos qualidade e soluções personalizadas.',
              Colors.orangeAccent, // Cor para o ícone
            ),
            const SizedBox(height: 16.0),
            buildCardSection(
              'Fundação',
              Icons.business,
              'Inovamos no e-commerce para gamers, focando em excelência e satisfação.',
              Colors.blueAccent, // Cor para o ícone
            ),
            const SizedBox(height: 16.0),
            buildCardSection(
              'Equipe',
              Icons.group,
              'Uma equipe dedicada a oferecer as melhores soluções do mercado gamer.',
              Colors.redAccent, // Cor para o ícone
            ),
            const SizedBox(height: 16.0),
            buildCardSection(
              'Nossa Visão',
              Icons.visibility,
              'Ser referência em e-commerce para gamers, com inovação e qualidade.',
              Colors.greenAccent, // Cor para o ícone
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget buildCardSection(String title, IconData icon, String description, Color iconColor) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 8,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 60, 
                color: iconColor, // A cor do ícone agora é dinâmica
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 238, 239, 239),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const AnimatedRow({super.key, 
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Adicionando o logo ao lado do texto
        Image.asset(
          'assets/logo.png', // Substitua pelo caminho da sua imagem
          width: 60, // Tamanho da imagem, ajuste conforme necessário
          height: 60, // Tamanho da imagem, ajuste conforme necessário
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 400),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class AnimatedText extends StatelessWidget {
  final String text;

  const AnimatedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
    );
  }
}
