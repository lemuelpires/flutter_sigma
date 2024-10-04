import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/repositories/anuncio_repositories.dart';
import 'package:logger/logger.dart';

class AnuncioProvider with ChangeNotifier {
  final AnuncioRepository anuncioRepository;
  final Logger logger = Logger(); // Instância do Logger

  AnuncioProvider(this.anuncioRepository);

  List<Anuncio> _anuncios = [];
  List<Anuncio> get anuncios => _anuncios;

  // Método para carregar anúncios
  Future<void> loadAnuncios() async {
    try {
      _anuncios = await anuncioRepository.getAnuncios();
      notifyListeners(); // Notifica os ouvintes para atualizar a interface
      logger.i("Anúncios carregados com sucesso: ${_anuncios.length} itens");
    } catch (e) {
      logger.e("Erro ao carregar anúncios: $e");
    }
  }

  // Método para adicionar um anúncio
  Future<void> addAnuncio(Anuncio anuncio) async {
    try {
      Anuncio newAnuncio = await anuncioRepository.addAnuncio(anuncio);
      _anuncios.add(newAnuncio);
      notifyListeners(); // Atualiza a interface
      logger.i("Anúncio adicionado com sucesso: ${newAnuncio.idAnuncio}");
    } catch (e) {
      logger.e("Erro ao adicionar anúncio: $e");
    }
  }

  // Método para atualizar um anúncio
  Future<void> updateAnuncio(Anuncio anuncio) async {
    try {
      Anuncio updatedAnuncio = await anuncioRepository.updateAnuncio(anuncio);
      int index = _anuncios.indexWhere((a) => a.idAnuncio == updatedAnuncio.idAnuncio);
      if (index != -1) {
        _anuncios[index] = updatedAnuncio; // Atualiza o anúncio na lista
        notifyListeners(); // Atualiza a interface
        logger.i("Anúncio atualizado com sucesso: ${updatedAnuncio.idAnuncio}");
      } else {
        logger.w("Anúncio não encontrado para atualização: ${anuncio.idAnuncio}");
      }
    } catch (e) {
      logger.e("Erro ao atualizar anúncio: $e");
    }
  }

  // Método para remover um anúncio
  Future<void> deleteAnuncio(int idAnuncio) async {
    try {
      await anuncioRepository.deleteAnuncio(idAnuncio);
      _anuncios.removeWhere((a) => a.idAnuncio == idAnuncio); // Remove o anúncio da lista
      notifyListeners(); // Atualiza a interface
      logger.i("Anúncio removido com sucesso: $idAnuncio");
    } catch (e) {
      logger.e("Erro ao deletar anúncio: $e");
    }
  }
}
