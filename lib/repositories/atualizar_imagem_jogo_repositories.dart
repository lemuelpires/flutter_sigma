import 'package:dio/dio.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/api/api_response.dart';
import 'package:flutter_sigma/api/api_endpoints.dart';

class JogoRepository {
  final Dio dio; // Instância do Dio

  JogoRepository(this.dio);

  // Método para atualizar a imagem do jogo
  Future<ApiResponse<Jogo>> updateImagemJogo(int idJogo, String novaReferenciaImagem) async {
    try {
      final response = await dio.patch(
        '${ApiEndpoints.jogo}/$idJogo', // Ajuste a URL conforme necessário
        data: {'referenciaImagemJogo': novaReferenciaImagem},
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(Jogo.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao atualizar a imagem do jogo. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar a imagem do jogo: $e');
    }
  }
}
