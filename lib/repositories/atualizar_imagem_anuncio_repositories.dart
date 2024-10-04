import 'package:dio/dio.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';

class AnuncioRepository {
  final Dio dio; // Instância do Dio

  AnuncioRepository(this.dio);

  // Método para atualizar a imagem do anúncio
  Future<Anuncio> updateAnuncioImage(int idAnuncio, String novaReferenciaImagem) async {
    try {
      final response = await dio.patch('/anuncios/$idAnuncio', // Ajuste a URL conforme necessário
        data: {
          'referenciaImagem': novaReferenciaImagem,
        },
      );

      if (response.statusCode == 200) {
        return Anuncio.fromJson(response.data);
      } else {
        throw Exception('Falha ao atualizar a imagem do anúncio');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar a imagem do anúncio: $e');
    }
  }
}
