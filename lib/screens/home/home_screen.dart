// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_sigma/widgets/header.dart';
import 'package:flutter_sigma/widgets/footer.dart'; // Importando o Footer

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Altura do AppBar (Header)
        child: CustomHeader(), // Usando o Header customizado
      ),
      body: Center(
        child: Text(
          'Bem-vindo ao Sigma Hardware!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: Footer(), // Adicionando o Footer
    );
  }
}
