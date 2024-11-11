import 'package:dio/dio.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/api/api_response.dart';
import 'package:flutter_sigma/api/api_endpoints.dart';

class AnuncioRepository {
  final Dio dio; // Instância do Dio

  AnuncioRepository(this.dio);

  // Método para atualizar a imagem do anúncio
  Future<ApiResponse<Anuncio>> updateAnuncioImage(int idAnuncio, String novaReferenciaImagem) async {
    try {
      final response = await dio.patch(
        '${ApiEndpoints.anuncio}/$idAnuncio', // Ajuste a URL conforme necessário
        data: {'referenciaImagem': novaReferenciaImagem},
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(Anuncio.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao atualizar a imagem do anúncio. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar a imagem do anúncio: $e');
    }
  }
}
