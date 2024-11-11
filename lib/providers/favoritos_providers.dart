import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/favoritos_model.dart';
import 'package:flutter_sigma/repositories/favoritos_repositories.dart';
import 'package:logging/logging.dart';
import 'package:flutter_sigma/api/api_response.dart';

final Logger _logger = Logger('FavoritoProvider');

class FavoritoProvider with ChangeNotifier {
  final FavoritoRepository favoritoRepository;

  FavoritoProvider(this.favoritoRepository);

  List<Favorito> _favoritos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Favorito> get favoritos => _favoritos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todos os favoritos de um usuário
  Future<void> loadFavoritos(int idUsuario) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await favoritoRepository.getFavoritos(idUsuario);
      if (response.success) {
        _favoritos = response.data!;
      } else {
        _errorMessage = response.message;
        _favoritos = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar favoritos: $error');
      _errorMessage = 'Erro ao carregar favoritos: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um novo favorito
  Future<void> addFavorito(Favorito favorito) async {
    try {
      final response = await favoritoRepository.addFavorito(favorito);
      if (response.success) {
        _favoritos.add(response.data!);
        notifyListeners();
        _logger.info('Favorito adicionado com sucesso: ${favorito.idFavorito}');
      } else {
        _logger.severe('Erro ao adicionar favorito: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar favorito: $error');
    }
  }

  // Método para atualizar um favorito
  Future<void> updateFavorito(Favorito favorito) async {
    try {
      final response = await favoritoRepository.updateFavorito(favorito);
      if (response.success) {
        final index = _favoritos.indexWhere((e) => e.idFavorito == response.data!.idFavorito);
        if (index != -1) {
          _favoritos[index] = response.data!; // Atualiza o favorito na lista
          notifyListeners();
        }
        _logger.info('Favorito atualizado com sucesso: ${favorito.idFavorito}');
      } else {
        _logger.severe('Erro ao atualizar favorito: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar favorito: $error');
    }
  }

  // Método para deletar um favorito
  Future<void> deleteFavorito(int idFavorito) async {
    try {
      final response = await favoritoRepository.deleteFavorito(idFavorito);
      if (response.success) {
        _favoritos.removeWhere((e) => e.idFavorito == idFavorito); // Remove da lista
        notifyListeners();
        _logger.info('Favorito deletado com sucesso: $idFavorito');
      } else {
        _logger.severe('Erro ao deletar favorito: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao deletar favorito: $error');
    }
  }
}
