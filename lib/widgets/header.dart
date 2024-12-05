import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final Function(String) onSearch;

  const CustomHeader({super.key, required this.title, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    void _handleSearch() {
      onSearch(_searchController.text);
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF101419), // Fundo do Header
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (value) => _handleSearch(),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.grey[700]),
                        onPressed: _handleSearch,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    child: Text('Página Inicial', style: TextStyle(color: Colors.black)),
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