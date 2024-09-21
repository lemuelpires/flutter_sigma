import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: const Color(0xFF101419), // Fundo do Header
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png',
              width: 40,
            ),
            
            // Campo de Pesquisa
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                  ),
                ),
              ),
            ),
            
            // Ícone de Login
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                // Ação ao clicar no ícone de login
              },
            ),
            
            // Menu Hambúrguer
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.white),
              onSelected: (value) {
                // Lógica para ação do menu
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'item1',
                    child: Text('Item 1', style: TextStyle(color: Colors.black)),
                  ),
                  const PopupMenuItem(
                    value: 'item2',
                    child: Text('Item 2', style: TextStyle(color: Colors.black)),
                  ),
                  const PopupMenuItem(
                    value: 'item3',
                    child: Text('Item 3', style: TextStyle(color: Colors.black)),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
