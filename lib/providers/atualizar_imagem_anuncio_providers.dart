import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/repositories/anuncio_repositories.dart';
import 'package:logger/logger.dart';

class AnuncioProvider with ChangeNotifier {
  final AnuncioRepository anuncioRepository;
  final Logger logger = Logger(); // Instância do Logger
  List<Anuncio> _anuncios = []; // Lista de anúncios

  AnuncioProvider(this.anuncioRepository);

  List<Anuncio> get anuncios => _anuncios; // Getter para os anúncios

  // Método para atualizar a imagem do anúncio
  Future<void> updateAnuncioImage(int idAnuncio, String novaReferenciaImagem) async {
    try {
      // Chama o método de repositório para atualizar a imagem
      final response = await anuncioRepository.updateAnuncioImage(idAnuncio, novaReferenciaImagem);
      
      if (response.success) {
        // Se a operação foi bem-sucedida, atualiza a lista de anúncios
        logger.i("Imagem do anúncio atualizada com sucesso: $idAnuncio");

        // Atualiza a lista de anúncios, caso o anúncio tenha sido atualizado
        final index = _anuncios.indexWhere((anuncio) => anuncio.idAnuncio == idAnuncio);
        if (index != -1) {
          // Atualize o anúncio na lista, provavelmente com a nova imagem ou outros detalhes
          _anuncios[index] = _anuncios[index]; // Se necessário, substitua ou modifique o objeto
          notifyListeners(); // Notifica os ouvintes para atualizar a interface
        }
      } else {
        logger.e("Erro ao atualizar a imagem do anúncio: ${response.message}");
      }
    } catch (e) {
      logger.e("Erro ao atualizar a imagem do anúncio: $e");
    }
  }

  // Método para carregar os anúncios (opcional)
  Future<void> loadAnuncios() async {
    try {
      final response = await anuncioRepository.getAnuncios();
      if (response.success) {
        _anuncios = response.data!; // Atualiza a lista de anúncios com os dados
      } else {
        logger.e("Erro ao carregar anúncios: ${response.message}");
        _anuncios = []; // Limpa a lista se houver erro
      }
      notifyListeners(); // Notifica os ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar anúncios: $e");
    }
  }
}
