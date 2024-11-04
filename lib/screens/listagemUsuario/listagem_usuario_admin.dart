import 'package:flutter/material.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';

class ListaUsuarios extends StatelessWidget {
  const ListaUsuarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Define a altura do header
        child: CustomHeader(title: 'header',), // Usa o seu componente de header
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Adicionar',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    // Implementar funcionalidade de adicionar usuário
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Quantidade de usuários (exemplo)
              itemBuilder: (context, index) {
                return UserCard(
                  name: 'Nome do Usuário $index', // Nome do usuário (exemplo)
                  phoneNumber: '123456789', // Telefone (exemplo)
                );
              },
            ),
          ),
          Footer(), // Usa o componente de footer
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const UserCard({super.key, required this.name, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 1), // Borda azul
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/50'), // Imagem de exemplo
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  phoneNumber,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implementar funcionalidade de excluir usuário
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text('Excluir', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  // Implementar funcionalidade de editar usuário
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text('Editar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
