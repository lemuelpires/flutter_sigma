import 'dart:math';
import 'package:flutter/material.dart';

class UsuarioCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const UsuarioCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.onDelete,
    required this.onEdit,
  });

  // Função para gerar uma cor aleatória que combina com verde
  Color _getRandomGreenColor() {
    final List<Color> greenColors = [
      Colors.green,                  // Verde original
      const Color.fromARGB(255, 78, 67, 199),         // Tom claro de verde
      const Color.fromARGB(255, 194, 122, 14),         // Tom claro de verde
      const Color.fromARGB(255, 228, 41, 212),         // Tom moderado de verde
      const Color.fromARGB(255, 87, 183, 192),         // Tom escuro de verde
      Colors.green.shade700,         // Tom escuro de verde
      Colors.teal,                   // Verde-azulado
      Colors.lightGreen,             // Verde claro
      Colors.lime,                   // Amarelo esverdeado
    ];
    
    final random = Random();
    return greenColors[random.nextInt(greenColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Obtém a inicial do nome (primeira letra do nome do usuário)
    String initial = name.isNotEmpty ? name[0].toUpperCase() : '';

    // Gera uma cor aleatória para o círculo que combina com verde
    Color borderColor = _getRandomGreenColor();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 164, 164, 164), // Cor da borda do card
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Circulo com a inicial do nome do usuário
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: borderColor.withOpacity(0.1), // Fundo mais suave
              borderRadius: BorderRadius.circular(25), // Deixa o círculo redondo
              border: Border.all(color: borderColor, width: 2), // Borda colorida
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  phoneNumber,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: onDelete,
              ),
              const SizedBox(height: 5),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                onPressed: onEdit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}