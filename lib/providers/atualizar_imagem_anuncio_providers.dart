import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/repositories/anuncio_repositories.dart';
import 'package:logging/logging.dart';
import 'package:flutter_sigma/api/api_response.dart';

final Logger _logger = Logger('AnuncioProvider');

class AnuncioProvider with ChangeNotifier {
  final AnuncioRepository anuncioRepository;

  AnuncioProvider(this.anuncioRepository);

  List<Anuncio> _anuncios = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Anuncio> get anuncios => _anuncios;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar os anúncios
  Future<void> loadAnuncios() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await anuncioRepository.getAnuncios();
      if (response.success) {
        _anuncios = response.data!;
      } else {
        _errorMessage = response.message;
        _anuncios = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar anúncios: $error');
      _errorMessage = 'Erro ao carregar anúncios: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para atualizar a imagem do anúncio
  Future<void> updateAnuncioImage(int idAnuncio, String novaReferenciaImagem) async {
    try {
      final response = await anuncioRepository.updateAnuncioImage(idAnuncio, novaReferenciaImagem);
      if (response.success) {
        _logger.info("Imagem do anúncio atualizada com sucesso: $idAnuncio");

        final index = _anuncios.indexWhere((anuncio) => anuncio.idAnuncio == idAnuncio);
        if (index != -1) {
          _anuncios[index] = _anuncios[index]; // Se necessário, atualize com os novos dados
          notifyListeners();
        }
      } else {
        _logger.severe("Erro ao atualizar a imagem do anúncio: ${response.message}");
      }
    } catch (e) {
      _logger.severe("Erro ao atualizar a imagem do anúncio: $e");
    }
  }

  // Método para adicionar um anúncio
  Future<void> addAnuncio(Anuncio anuncio) async {
    try {
      final response = await anuncioRepository.addAnuncio(anuncio);
      if (response.success) {
        _anuncios.add(response.data!);
        notifyListeners();
      } else {
        _logger.severe('Erro ao adicionar anúncio: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar anúncio: $error');
    }
  }

  // Método para remover um anúncio
  Future<void> deleteAnuncio(int idAnuncio) async {
    try {
      final response = await anuncioRepository.deleteAnuncio(idAnuncio);
      if (response.success) {
        _anuncios.removeWhere((anuncio) => anuncio.idAnuncio == idAnuncio);
        notifyListeners();
      } else {
        _logger.severe('Erro ao remover anúncio: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao remover anúncio: $error');
    }
  }
}
