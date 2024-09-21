import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF101419), // Cor de fundo
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Suporte',
                    style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Política de Privacidade',
                    style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Termos de Serviço',
                    style: TextStyle(color: Colors.white, fontSize: 14), // Diminuindo a fonte
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.instagram,
                color: Colors.white,
              ),
              SizedBox(width: 20),
              FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.white,
              ),
              SizedBox(width: 20),
              FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
