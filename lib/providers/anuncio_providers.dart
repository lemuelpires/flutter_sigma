import 'package:flutter/material.dart';
import 'package:flutter_sigma/api/api_response.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/repositories/anuncio_repositories.dart';
import 'package:logger/logger.dart';

class AnuncioProvider with ChangeNotifier {
  final AnuncioRepository anuncioRepository;
  final Logger logger = Logger();

  List<Anuncio> _anuncios = [];
  List<Anuncio> _filteredAnuncios = []; // Lista filtrada para pesquisa
  bool _isLoading = false;
  String? _errorMessage;

  AnuncioProvider(this.anuncioRepository);

  List<Anuncio> get anuncios => _anuncios;
  List<Anuncio> get filteredAnuncios => _filteredAnuncios; // Getter para lista filtrada
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAnuncios() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final ApiResponse<List<Anuncio>> response = await anuncioRepository.getAnuncios();
      if (response.success) {
        _anuncios = response.data?.where((anuncio) => anuncio.ativo).toList() ?? [];
        _filteredAnuncios = _anuncios; // Inicializa a lista filtrada com todos os anúncios ativos
      } else {
        _errorMessage = response.message;
        _anuncios = [];
        _filteredAnuncios = [];
      }
    } catch (e) {
      _errorMessage = 'Erro ao carregar anúncios: $e';
      logger.e("Erro ao carregar anúncios: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para filtrar anúncios com base na pesquisa
  void filterAnuncios(String query) {
    if (query.isEmpty) {
      _filteredAnuncios = _anuncios; // Se a pesquisa estiver vazia, retorna todos os anúncios ativos
    } else {
      _filteredAnuncios = _anuncios.where((anuncio) {
        return anuncio.titulo.toLowerCase().contains(query.toLowerCase()); // Filtra pelo título
      }).toList();
    }
    notifyListeners(); // Notifica os ouvintes para atualizar a interface
  }

  // Método para adicionar um novo anúncio
  Future<void> addAnuncio(Anuncio anuncio) async {
    try {
      final response = await anuncioRepository.addAnuncio(anuncio);
      if (response.success) {
        _anuncios.add(response.data!);
        notifyListeners(); // Notifica os ouvintes
        logger.i("Anúncio adicionado com sucesso: ${response.data!.idAnuncio}");
      } else {
        _errorMessage = response.message;
        logger.e("Erro ao adicionar anúncio: ${response.message}");
      }
    } catch (e) {
      _errorMessage = 'Erro ao adicionar anúncio: $e';
      logger.e("Erro ao adicionar anúncio: $e");
    }
  }

  // Método para atualizar um anúncio
  Future<void> updateAnuncio(Anuncio anuncio) async {
    try {
      final response = await anuncioRepository.updateAnuncio(anuncio);
      if (response.success) {
        final index = _anuncios.indexWhere((a) => a.idAnuncio == anuncio.idAnuncio);
        if (index != -1) {
          _anuncios[index] = response.data!;
          notifyListeners(); // Notifica os ouvintes
          logger.i("Anúncio atualizado com sucesso: ${response.data!.idAnuncio}");
        }
      } else {
        _errorMessage = response.message;
        logger.e("Erro ao atualizar anúncio: ${response.message}");
      }
    } catch (e) {
      _errorMessage = 'Erro ao atualizar anúncio: $e';
      logger.e("Erro ao atualizar anúncio: $e");
    }
  }

  // Método para atualizar a imagem do anúncio
  Future<void> updateAnuncioImage(int idAnuncio, String novaReferenciaImagem) async {
    try {
      final response = await anuncioRepository.updateAnuncioImage(idAnuncio, novaReferenciaImagem);
      if (response.success) {
        // Atualiza a lista de anúncios, se necessário
        final index = _anuncios.indexWhere((anuncio) => anuncio.idAnuncio == idAnuncio);
        if (index != -1) {
          // Atualiza apenas a imagem do anúncio
          _anuncios[index] = _anuncios[index].copyWith(imagemReferencia: novaReferenciaImagem);
          notifyListeners(); // Notifica os ouvintes
        }
        logger.i("Imagem do anúncio atualizada com sucesso: $idAnuncio");
      } else {
        _errorMessage = response.message;
        logger.e("Erro ao atualizar a imagem do anúncio: ${response.message}");
      }
    } catch (e) {
      _errorMessage = 'Erro ao atualizar a imagem do anúncio: $e';
      logger.e("Erro ao atualizar a imagem do anúncio: $e");
    }
  }

  // Método para desativar um anúncio
  Future<void> disableAnuncio(int idAnuncio) async {
    try {
      final response = await anuncioRepository.disableAnuncio(idAnuncio);
      if (response.success) {
        final index = _anuncios.indexWhere((anuncio) => anuncio.idAnuncio == idAnuncio);
        if (index != -1) {
          _anuncios[index] = _anuncios[index].copyWith(ativo: false, imagemReferencia: '');
          notifyListeners(); // Notifica os ouvintes
          logger.i("Anúncio desativado com sucesso: $idAnuncio");
        }
      } else {
        _errorMessage = response.message;
        logger.e("Erro ao desativar anúncio: ${response.message}");
      }
    } catch (e) {
      _errorMessage = 'Erro ao desativar anúncio: $e';
      logger.e("Erro ao desativar anúncio: $e");
    }
  }
}