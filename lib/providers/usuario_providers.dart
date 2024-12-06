import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/usuario_model.dart';
import 'package:flutter_sigma/repositories/usuario_repositories.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('UsuarioProvider');

class UsuarioProvider with ChangeNotifier {
  final UsuarioRepository usuarioRepository;

  UsuarioProvider(this.usuarioRepository);

  List<Usuario> _usuarios = [];
  List<Usuario> _usuariosFiltrados = []; // Lista filtrada para pesquisa
  bool _isLoading = false;
  String? _errorMessage;

  List<Usuario> get usuarios => _usuariosFiltrados.isEmpty ? _usuarios : _usuariosFiltrados;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todos os usuários
  Future<void> fetchUsuarios() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await usuarioRepository.getUsuarios();
      if (response.success) {
        _usuarios = response.data?.where((usuario) => usuario.ativo).toList() ?? [];
        _usuariosFiltrados = []; // Resetar a lista filtrada quando novos dados forem carregados
      } else {
        _errorMessage = response.message;
        _usuarios = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar usuários: $error');
      _errorMessage = 'Erro ao carregar usuários: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um novo usuário
  Future<void> addUsuario(Usuario usuario) async {
    try {
      final response = await usuarioRepository.addUsuario(usuario);
      if (response.success) {
        _usuarios.add(response.data!);
        notifyListeners();
        _logger.info('Usuário adicionado com sucesso: ${response.data!.idUsuario}');
      } else {
        _logger.severe('Erro ao adicionar usuário: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar usuário: $error');
    }
  }

  // Método para atualizar um usuário
  Future<void> updateUsuario(Usuario usuario) async {
    try {
      final response = await usuarioRepository.updateUsuario(usuario);
      if (response.success) {
        final index = _usuarios.indexWhere((u) => u.idUsuario == response.data!.idUsuario);
        if (index != -1) {
          _usuarios[index] = response.data!;
          notifyListeners();
        }
        _logger.info('Usuário atualizado com sucesso: ${response.data!.idUsuario}');
      } else {
        _logger.severe('Erro ao atualizar usuário: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar usuário: $error');
    }
  }

  // Método para desativar um usuário
  Future<void> disableUsuario(int idUsuario) async {
    try {
      final response = await usuarioRepository.disableUsuario(idUsuario);
      if (response.success) {
        final index = _usuarios.indexWhere((u) => u.idUsuario == idUsuario);
        if (index != -1) {
          _usuarios[index] = _usuarios[index].copyWith(ativo: false);
          notifyListeners();
          _logger.info('Usuário desativado com sucesso: $idUsuario');
        }
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao desativar usuário: ${response.message}');
      }
    } catch (error) {
      _errorMessage = 'Erro ao desativar usuário: $error';
      _logger.severe('Erro ao desativar usuário: $error');
    }
  }

  // Método para filtrar a lista de usuários com base no nome
  void filterUsuarios(String query) {
    if (query.isEmpty) {
      _usuariosFiltrados.clear(); // Se a pesquisa estiver vazia, mostrar todos os usuários
    } else {
      _usuariosFiltrados = _usuarios
          .where((usuario) => usuario.nome.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notificar a UI para atualizar a lista
  }

  // Método para atualizar um usuário na lista localmente
  void updateUsuarioInList(Usuario updatedUsuario) {
    final index = _usuarios.indexWhere((u) => u.idUsuario == updatedUsuario.idUsuario);
    if (index != -1) {
      _usuarios[index] = updatedUsuario;
      _usuariosFiltrados = List.from(_usuarios);
      notifyListeners();
    }
  }
}