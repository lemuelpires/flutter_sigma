import 'package:flutter/material.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';

class AmbienteAdministradorScreen extends StatelessWidget {
  const AmbienteAdministradorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambiente do Usuário'),
      ),
      body: Column(
        children: [
          // Header
          const CustomHeader(),
          // Conteúdo Principal
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              children: [
                // Produtos
                _buildMenuItem(
                  context,
                  icon: Icons.store,
                  label: 'Produtos',
                  onTap: () {
                    // Navegar para a página de produtos
                  },
                ),
                // Anúncios
                _buildMenuItem(
                  context,
                  icon: Icons.announcement,
                  label: 'Anúncios',
                  onTap: () {
                    // Navegar para a página de anúncios
                  },
                ),
                // Usuários
                _buildMenuItem(
                  context,
                  icon: Icons.supervised_user_circle,
                  label: 'Usuários',
                  onTap: () {
                    // Navegar para a página de usuários
                  },
                ),
                // Jogos
                _buildMenuItem(
                  context,
                  icon: Icons.videogame_asset,
                  label: 'Jogos',
                  onTap: () {
                    // Navegar para a página de jogos
                  },
                ),
                // Imagens
                _buildMenuItem(
                  context,
                  icon: Icons.image,
                  label: 'Imagens',
                  onTap: () {
                    // Navegar para a página de imagens
                  },
                ),
              ],
            ),
          ),
          // Footer
          const Footer(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF1D2128), // Usar uma cor escura como fundo dos cards
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

