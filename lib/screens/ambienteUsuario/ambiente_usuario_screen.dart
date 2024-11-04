/*import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Olá João, em que\npodemos ajudar?',
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
                ),
                MenuButton(
                  icon: Icons.article,
                  label: 'Anúncios',
                  color: Colors.orangeAccent,
                ),
                MenuButton(
                  icon: Icons.group,
                  label: 'Usuarios',
                  color: Colors.pinkAccent,
                ),
                MenuButton(
                  icon: Icons.videogame_asset,
                  label: 'Jogos',
                  color: Colors.white,
                  borderColor: Colors.blue,
                ),
                MenuButton(
                  icon: Icons.image,
                  label: 'Imagens',
                  color: Colors.greenAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color? borderColor;

  const MenuButton({
    required this.icon,
    required this.label,
    required this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
*/