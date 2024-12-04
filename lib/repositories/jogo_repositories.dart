import 'package:flutter/foundation.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/api/api_endpoints.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/api/api_response.dart';

class JogoRepository {
  final ApiClient apiClient;

  JogoRepository(this.apiClient);

  // Método para obter todos os jogos
  Future<ApiResponse<List<Jogo>>> getJogos() async {
    try {
      final response = await apiClient.get(ApiEndpoints.jogo);
      if (response.statusCode == 200) {
        List data = response.data as List;
        List<Jogo> jogos = data.map((e) => Jogo.fromJson(e)).toList();
        return ApiResponse.success(jogos);
      } else {
        return ApiResponse.error('Falha ao carregar jogos. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao buscar jogos: $e');
    }
  }

  // Método para adicionar um novo jogo
  Future<ApiResponse<Jogo>> addJogo(Jogo jogo) async {
    try {
      if (kDebugMode) {
        print(jogo.toJson());
      }
      final response = await apiClient.post(ApiEndpoints.jogo, data: jogo.toJson());
      if (response.statusCode == 201) {
        return ApiResponse.success(Jogo.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao adicionar jogo. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar jogo: $e');
    }
  }

  // Método para atualizar um jogo existente
  Future<ApiResponse<Jogo>> updateJogo(Jogo jogo) async {
    try {
      final response = await apiClient.put('${ApiEndpoints.jogo}/${jogo.idJogo}', data: jogo.toJson());
      if (response.statusCode == 200) {
        return ApiResponse.success(Jogo.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao atualizar jogo. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar jogo: $e');
    }
  }

  // Método para remover um jogo
   Future<ApiResponse<void>> disableJogo(int idJogo) async {
    try {
      final response =
          await apiClient.patch('${ApiEndpoints.jogo}/$idJogo/disable');
      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(
            'Falha ao desativar anúncio. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao desativar anúncio: $e');
    }
  }
}