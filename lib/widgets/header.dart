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
        onSearch(query);
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

    final List<Color> borderColors = [
      const Color.fromARGB(255, 240, 175, 170),
      const Color.fromARGB(255, 128, 223, 131),
      const Color.fromARGB(255, 103, 177, 238),
      const Color.fromARGB(255, 228, 195, 144),
      const Color.fromARGB(255, 222, 171, 231),
    ];

    final Color randomBorderColor = borderColors[Random().nextInt(borderColors.length)];

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.5 * 255).toInt()),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Image.asset('assets/logo.png', width: 40),
                ),
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
                            color: Colors.black.withAlpha((0.2 * 255).toInt()),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
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
                user != null
                    ? PopupMenuButton<String>(
                        icon: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: randomBorderColor, width: 2.0),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text(
                              user.displayName != null && user.displayName!.isNotEmpty
                                  ? user.displayName![0].toUpperCase()
                                  : user.email![0].toUpperCase(),
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onSelected: (value) {
                          if (value == 'logout') {
                            handleLogout();
                          } else {
                            Navigator.pushNamed(context, value);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            menuItem('Página Inicial', '/home'),
                            menuItem('Área Administrativa', '/ambiente_administrador'),
                            menuItem('Meu Perfil', '/em_construcao', detail: user.email),
                            menuItem('Sobre Nós', '/sobre'),
                            menuItem('Contatos', '/contatos'),
                            menuItem('Sair', 'logout'),
                          ];
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.person, color: Colors.white, size: 35),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> menuItem(String title, String value, {String? detail}) {
    return PopupMenuItem(
      value: value,
      child: MouseRegion(
        onEnter: (event) {
          // Lógica para iniciar animação
        },
        onExit: (event) {
          // Lógica para finalizar animação
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
