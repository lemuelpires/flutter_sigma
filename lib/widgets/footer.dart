import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF101419), // Cor de fundo
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               GestureDetector(
                onTap: () => _navigateTo(context, '/em_construcao'),
                child: const Text(
                  'Suporte',
                  style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                ),
              ),
              GestureDetector(
                onTap: () => _navigateTo(context, '/politica_privacidade'),
                child: const Text(
                  'Política de Privacidade',
                  style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                ),
              ),
              GestureDetector(
                onTap: () => _navigateTo(context, '/termos_condicoes'),
                child: const Text(
                  'Termos de Serviço',
                  style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _navigateTo(context, 'https://www.instagram.com'),
                child: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => _navigateTo(context, 'https://www.facebook.com'),
                child: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => _navigateTo(context, 'https://www.twitter.com'),
                child: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}