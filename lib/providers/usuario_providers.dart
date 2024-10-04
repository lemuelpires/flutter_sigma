import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/usuario_model.dart';
import 'package:flutter_sigma/repositories/usuario_repositories.dart';
import 'package:logger/logger.dart';

class UsuarioProvider with ChangeNotifier {
  final UsuarioRepository usuarioRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<Usuario> _usuarios = [];

  UsuarioProvider(this.usuarioRepository);

  List<Usuario> get usuarios => _usuarios;

  // Método para carregar todos os usuários
  Future<void> loadUsuarios() async {
    try {
      _usuarios = await usuarioRepository.getUsuarios();
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar usuários: $e");
    }
  }

  // Método para adicionar um novo usuário
  Future<void> addUsuario(Usuario usuario) async {
    try {
      Usuario newUsuario = await usuarioRepository.addUsuario(usuario);
      _usuarios.add(newUsuario);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Usuário adicionado com sucesso: ${usuario.idUsuario}");
    } catch (e) {
      logger.e("Erro ao adicionar usuário: $e");
    }
  }

  // Método para atualizar um usuário
  Future<void> updateUsuario(Usuario usuario) async {
    try {
      Usuario updatedUsuario = await usuarioRepository.updateUsuario(usuario);
      int index = _usuarios.indexWhere((e) => e.idUsuario == updatedUsuario.idUsuario);
      if (index != -1) {
        _usuarios[index] = updatedUsuario; // Atualiza o usuário na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Usuário atualizado com sucesso: ${usuario.idUsuario}");
    } catch (e) {
      logger.e("Erro ao atualizar usuário: $e");
    }
  }

  // Método para deletar um usuário
  Future<void> deleteUsuario(int idUsuario) async {
    try {
      await usuarioRepository.deleteUsuario(idUsuario);
      _usuarios.removeWhere((e) => e.idUsuario == idUsuario); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Usuário deletado com sucesso: $idUsuario");
    } catch (e) {
      logger.e("Erro ao deletar usuário: $e");
    }
  }
}
