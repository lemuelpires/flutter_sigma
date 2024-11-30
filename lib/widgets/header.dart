import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required String title});

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
                Navigator.pushNamed(context, value);
              },
              itemBuilder: (BuildContext context) {
                return [
                   const PopupMenuItem(
                    value: '/home',
                    child: Text('pagina inicial', style: TextStyle(color: Colors.black)),
                  ),
                  const PopupMenuItem(
                    value: '/ambiente_administrador',
                    child: Text('Ambiente Administrador', style: TextStyle(color: Colors.black)),
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
