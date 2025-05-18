import 'package:flutter/material.dart';

class Etapa2Screen extends StatefulWidget {
  const Etapa2Screen({super.key});

  @override
  Etapa2ScreenState createState() => Etapa2ScreenState();
}

class Etapa2ScreenState extends State<Etapa2Screen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Ação', 'icon': Icons.flash_on, 'color': Colors.red},
    {'name': 'Aventura', 'icon': Icons.explore, 'color': Colors.blue},
    {'name': 'Puzzle', 'icon': Icons.abc_outlined, 'color': Colors.orange},
    {'name': 'Simulação', 'icon': Icons.computer, 'color': Colors.green},
    {'name': 'RPG', 'icon': Icons.videogame_asset, 'color': Colors.purple},
    {'name': 'Estratégia', 'icon': Icons.public, 'color': Colors.teal},
    {'name': 'Horror', 'icon': Icons.local_bar, 'color': Colors.indigo},
    {'name': 'Musica', 'icon': Icons.music_note, 'color': Colors.pink},
    {'name': 'Esportes', 'icon': Icons.sports, 'color': Colors.yellow},
  ];

  Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final nome = args['nome'];
    final idade = args['idade'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            Text(
              'Olá $nome, de quais categorias você mais gosta?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  bool isSelected =
                      selectedCategories.contains(category['name']);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCategories.remove(category['name']);
                        } else {
                          selectedCategories.add(category['name']);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category[
                              'color'], // Cor única para cada categoria
                          width: .5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'],
                            color: category['color'], // Cor do ícone
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            category['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/etapa3', arguments: args);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.yellow,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
