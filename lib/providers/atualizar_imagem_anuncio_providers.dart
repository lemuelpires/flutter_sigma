import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/repositories/anuncio_repositories.dart';
import 'package:logger/logger.dart';

class AnuncioProvider with ChangeNotifier {
  final AnuncioRepository anuncioRepository;
  final Logger logger = Logger(); // Instância do Logger
  final List<Anuncio> _anuncios = []; // Supondo que você tenha uma lista de anúncios

  AnuncioProvider(this.anuncioRepository);

  // Método para atualizar a imagem do anúncio
  Future<void> updateAnuncioImage(int idAnuncio, String novaReferenciaImagem) async {
    try {
      Anuncio updatedAnuncio = await anuncioRepository.updateAnuncioImage(idAnuncio, novaReferenciaImagem);
      logger.i("Imagem do anúncio atualizada com sucesso: $idAnuncio");
      
      // Atualizar a lista de anúncios, se necessário
      final index = _anuncios.indexWhere((anuncio) => anuncio.idAnuncio == idAnuncio);
      if (index != -1) {
        _anuncios[index] = updatedAnuncio; // Atualiza o anúncio na lista
        notifyListeners(); // Notifica os ouvintes para atualizar a interface
      }
    } catch (e) {
      logger.e("Erro ao atualizar a imagem do anúncio: $e");
    }
  }
}
