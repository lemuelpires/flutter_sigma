import 'package:flutter/material.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';

class AmbienteAdministrador extends StatelessWidget {
  const AmbienteAdministrador({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          CustomHeader(title: 'header'), // Adiciona o Header
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ambiente Administrador\nOlá João, em que podemos ajudar?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      MenuButton(
                        icon: Icons.inventory,
                        label: 'Produtos',
                        color: Colors.cyanAccent,
                        routeName: '/lista_produtos',
                      ),
                      MenuButton(
                        icon: Icons.article,
                        label: 'Anúncios',
                        color: Colors.orangeAccent,
                        routeName: '/lista_anuncios',
                      ),
                      MenuButton(
                        icon: Icons.group,
                        label: 'Usuarios',
                        color: Colors.pinkAccent,
                        routeName: '/lista_usuarios',
                      ),
                      MenuButton(
                        icon: Icons.videogame_asset,
                        label: 'Jogos',
                        color: Colors.white,
                        borderColor: Colors.blue,
                        routeName: '/lista_jogos',
                      ),
                      MenuButton(
                        icon: Icons.image,
                        label: 'Imagens',
                        color: Colors.greenAccent,
                        routeName: '/lista_imagens', // Adicione esta rota se necessário
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Footer(), // Adiciona o Footer
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color? borderColor;
  final String routeName;

  const MenuButton({
    super.key, 
    required this.icon,
    required this.label,
    required this.color,
    required this.routeName,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor ?? Colors.transparent, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
