import 'package:flutter/material.dart';
import 'package:flutter_sigma/providers/usuario_providers.dart';
import 'package:flutter_sigma/screens/auth/register_screen.dart';
import 'package:flutter_sigma/screens/edicaoUsuario/edicao_usuario_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({super.key});

  @override
  ListaUsuariosState createState() => ListaUsuariosState();
}

class ListaUsuariosState extends State<ListaUsuarios> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UsuarioProvider>(context, listen: false).fetchUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: const CustomHeader(title: 'Usuários'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistroScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: usuarioProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : usuarioProvider.errorMessage != null
                    ? Center(child: Text(usuarioProvider.errorMessage!))
                    : usuarioProvider.usuarios.isEmpty
                        ? const Center(child: Text('Nenhum usuário encontrado.'))
                        : ListView.builder(
                            itemCount: usuarioProvider.usuarios.length,
                            itemBuilder: (context, index) {
                              final usuario = usuarioProvider.usuarios[index];
                              return UserCard(
                                name: usuario.nome,
                                phoneNumber: usuario.telefone,
                                onDelete: () {
                                  usuarioProvider.deleteUsuario(usuario.idUsuario!);
                                },
                                onEdit: () {
                                  // Navegar para a tela de edição passando o usuário selecionado
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditarUsuario(usuario: usuario),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const UserCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage('https://via.placeholder.com/50'), // Imagem de exemplo
                fit: BoxFit.cover,
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
              ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: const Text('Excluir', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: onEdit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: const Text('Editar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
