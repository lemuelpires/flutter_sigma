import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
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
              Row(
                children: const [
                  SizedBox(width: 10),
                  Text(
                    'Suporte',
                    style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                  ),
                ],
              ),
              Row(
                children: const [
                  SizedBox(width: 10),
                  Text(
                    'Política de Privacidade',
                    style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                  ),
                ],
              ),
              Row(
                children: const [
                  SizedBox(width: 10),
                  Text(
                    'Termos de Serviço',
                    style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _launchURL('https://www.instagram.com'),
                child: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => _launchURL('https://www.facebook.com'),
                child: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => _launchURL('https://www.twitter.com'),
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