import 'package:flutter/material.dart';
import 'package:flutter_sigma/api/api_response.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/repositories/anuncio_repositories.dart';
import 'package:logger/logger.dart';

class AnuncioProvider with ChangeNotifier {
  final AnuncioRepository anuncioRepository;
  final Logger logger = Logger(); // Instância do Logger
  List<Anuncio> _anuncios = []; // Lista privada de anúncios

  AnuncioProvider(this.anuncioRepository);

  // Getter para acessar a lista de anúncios
  List<Anuncio> get anuncios => _anuncios;

  // Método para carregar os anúncios
  Future<void> loadAnuncios() async {
    try {
      // Aqui você deve buscar os dados do repositório (exemplo fictício)
      final ApiResponse<List<Anuncio>> response = await anuncioRepository.getAnuncios();
      
      if (response.success) {
        _anuncios = response.data ?? []; // Atribui a lista de anúncios
        notifyListeners(); // Notifica os ouvintes para atualizar a interface
      } else {
        logger.e("Erro ao carregar anúncios: ${response.message}");
      }
    } catch (e) {
      logger.e("Erro ao carregar anúncios: $e");
    }
  }

  // Método para atualizar a imagem do anúncio
  Future<void> updateAnuncioImage(int idAnuncio, String novaReferenciaImagem) async {
    try {
      final response = await anuncioRepository.updateAnuncioImage(idAnuncio, novaReferenciaImagem);
      if (response.success) {
        logger.log(Level.info, "Imagem do anúncio atualizada com sucesso: $idAnuncio");
        
        // Atualizar a lista de anúncios, se necessário
        final index = _anuncios.indexWhere((anuncio) => anuncio.idAnuncio == idAnuncio);
        if (index != -1) {
          _anuncios[index] = _anuncios[index]; // Atualiza o anúncio na lista
          notifyListeners(); // Notifica os ouvintes para atualizar a interface
        }
      } else {
        logger.e("Erro ao atualizar a imagem do anúncio: ${response.message}");
      }
    } catch (e) {
      logger.e("Erro ao atualizar a imagem do anúncio: $e");
    }
  }
}
