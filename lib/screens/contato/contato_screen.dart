import 'package:flutter/material.dart';

class ContatosPage extends StatelessWidget {
  const ContatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            const Text(
              'Entre em contato conosco:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Estamos prontos para atender suas dúvidas e fornecer suporte de qualidade.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24.0),
            buildContactCard(
              'Telefone',
              Icons.phone,
              '(11) 1234-5678',
              Colors.green, // Cor do ícone Telefone
            ),
            const SizedBox(height: 16.0),
            buildContactCard(
              'Email',
              Icons.email,
              'contato@sigmashardware.com.br',
              Colors.blue, // Cor do ícone Email
            ),
            const SizedBox(height: 16.0),
            buildContactCard(
              'Endereço',
              Icons.location_on,
              'Rua Prudente da Silva, 123 - São Paulo, SP',
              Colors.red, // Cor do ícone Endereço
            ),
            const SizedBox(height: 16.0),
            buildContactCard(
              'Redes Sociais',
              Icons.share,
              'Facebook: Sigma Hardware\nInstagram: @sigma_hardware',
              Colors.orange, // Cor do ícone Redes Sociais
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget buildContactCard(String title, IconData icon, String description, Color iconColor) {
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
                size: 28,
                color: iconColor,  // Utiliza a cor alternada
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
                        color: Colors.white70,
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
