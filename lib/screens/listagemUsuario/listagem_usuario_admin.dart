import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/usuario_model.dart';
import 'package:flutter_sigma/providers/usuario_providers.dart';
import 'package:flutter_sigma/screens/auth/register_screen.dart';
import 'package:flutter_sigma/screens/edicaoUsuario/edicao_usuario_screen.dart';
import 'package:flutter_sigma/widgets/usuario_card.dart'; // Importe o UsuarioCard aqui
import 'package:provider/provider.dart';

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

  Future<void> _confirmDisableUsuario(BuildContext context, int idUsuario) async {
    final provider = Provider.of<UsuarioProvider>(context, listen: false);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja excluir esse cadastro?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await provider.disableUsuario(idUsuario);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário excluído com sucesso')),
      );
      provider.fetchUsuarios(); // Atualiza a listagem após a desativação
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Column(
            children: [
              const SizedBox(height: 40), // Adiciona espaço no início da página
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Row(
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
                              MaterialPageRoute(
                                  builder: (context) => RegistroScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Campo de pesquisa
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) {
                    // Chama o método de filtro no Provider para realizar a pesquisa
                    context.read<UsuarioProvider>().filterUsuarios(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'Pesquisar...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Espaço após o campo de pesquisa
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
                                  return UsuarioCard(
                                    name: usuario.nome,
                                    phoneNumber: usuario.telefone,
                                    onDisable: () async {
                                      await _confirmDisableUsuario(
                                          context, usuario.idUsuario!);
                                    },
                                    onEdit: () async {
                                      final updatedUsuario = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditarUsuario(usuario: usuario),
                                        ),
                                      ) as Usuario?;
                                      if (updatedUsuario != null) {
                                        usuarioProvider.updateUsuarioInList(updatedUsuario);
                                      }
                                    },
                                  );
                                },
                              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}