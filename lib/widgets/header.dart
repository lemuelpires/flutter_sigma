import 'package:flutter/material.dart';
import 'package:flutter_sigma/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class CustomHeader extends StatelessWidget {
  final String title;
  final Function(String) onSearch;

  const CustomHeader({super.key, required this.title, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final user = Provider.of<FirebaseAuthService>(context).currentUser;

    void handleSearch() {
      final query = searchController.text;
      if (query.isNotEmpty) {
        Navigator.pushNamed(
          context,
          '/home_lista',
          arguments: query,
        );
      }
    }

    void handleLogout() async {
      final authService = Provider.of<FirebaseAuthService>(context, listen: false);
      await authService.logout();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário deslogado')),
        );
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }

    // Lista de cores para a borda
    final List<Color> borderColors = [
      const Color.fromARGB(255, 240, 175, 170),
      const Color.fromARGB(255, 128, 223, 131),
      const Color.fromARGB(255, 103, 177, 238),
      const Color.fromARGB(255, 228, 195, 144),
      const Color.fromARGB(255, 222, 171, 231),
    ];

    // Seleciona uma cor aleatória da lista
    final Color randomBorderColor = borderColors[Random().nextInt(borderColors.length)];

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
                    controller: searchController,
                    onSubmitted: (value) => handleSearch(),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.grey[700]),
                        onPressed: handleSearch,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                  ),
                ),
              ),
            ),
            
            // Ícone de Login ou Inicial do Usuário
            user != null
                ? PopupMenuButton<String>(
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: randomBorderColor, // Cor da borda aleatória
                          width: 2.0, // Largura da borda
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent, // Sem fundo
                        child: Text(
                          user.displayName != null && user.displayName!.isNotEmpty
                              ? user.displayName![0].toUpperCase()
                              : user.email![0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center, // Centraliza a letra
                        ),
                      ),
                    ),
                    onSelected: (value) {
                      if (value == 'logout') {
                        handleLogout();
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: 'logout',
                          child: Text('Sair', style: TextStyle(color: Colors.black)),
                        ),
                      ];
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
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