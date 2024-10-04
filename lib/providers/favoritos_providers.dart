import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/favoritos_model.dart';
import 'package:flutter_sigma/repositories/favoritos_repositories.dart';
import 'package:logger/logger.dart';

class FavoritoProvider with ChangeNotifier {
  final FavoritoRepository favoritoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<Favorito> _favoritos = [];

  FavoritoProvider(this.favoritoRepository);

  List<Favorito> get favoritos => _favoritos;

  // Método para carregar todos os favoritos de um usuário
  Future<void> loadFavoritos(int idUsuario) async {
    try {
      _favoritos = await favoritoRepository.getFavoritos(idUsuario);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar favoritos: $e");
    }
  }

  // Método para adicionar um novo favorito
  Future<void> addFavorito(Favorito favorito) async {
    try {
      Favorito newFavorito = await favoritoRepository.addFavorito(favorito);
      _favoritos.add(newFavorito);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Favorito adicionado com sucesso: ${favorito.idFavorito}");
    } catch (e) {
      logger.e("Erro ao adicionar favorito: $e");
    }
  }

  // Método para atualizar um favorito
  Future<void> updateFavorito(Favorito favorito) async {
    try {
      Favorito updatedFavorito = await favoritoRepository.updateFavorito(favorito);
      int index = _favoritos.indexWhere((e) => e.idFavorito == updatedFavorito.idFavorito);
      if (index != -1) {
        _favoritos[index] = updatedFavorito; // Atualiza o favorito na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Favorito atualizado com sucesso: ${favorito.idFavorito}");
    } catch (e) {
      logger.e("Erro ao atualizar favorito: $e");
    }
  }

  // Método para deletar um favorito
  Future<void> deleteFavorito(int idFavorito) async {
    try {
      await favoritoRepository.deleteFavorito(idFavorito);
      _favoritos.removeWhere((e) => e.idFavorito == idFavorito); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Favorito deletado com sucesso: $idFavorito");
    } catch (e) {
      logger.e("Erro ao deletar favorito: $e");
    }
  }
}
