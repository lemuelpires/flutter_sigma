import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/api/api_endpoints.dart';
import 'package:flutter_sigma/api/api_response.dart';
import 'dart:convert';

class JogoRepository {
  final ApiClient apiClient;

  JogoRepository(this.apiClient);

  // Método para obter todos os jogos
  Future<ApiResponse<List<Jogo>>> getJogos() async {
    try {
      final response = await apiClient.get(ApiEndpoints.jogo);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data as List;
        List<Jogo> jogos = jsonList.map((json) => Jogo.fromJson(json)).toList();
        return ApiResponse.success(jogos);
      } else {
        return ApiResponse.error('Falha ao carregar jogos. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao buscar jogos: $e');
    }
  }

  // Método para obter um jogo pelo ID
  Future<ApiResponse<Jogo>> getJogo(int idJogo) async {
    try {
      final response = await apiClient.get('${ApiEndpoints.jogo}/$idJogo');
      if (response.statusCode == 200) {
        return ApiResponse.success(Jogo.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao carregar o jogo. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao buscar o jogo: $e');
    }
  }

  // Método para adicionar um novo jogo
  Future<ApiResponse<Jogo>> addJogo(Jogo jogo) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.jogo,
        data: jogo.toJson(),
      );
      if (response.statusCode == 201) {
        return ApiResponse.success(Jogo.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao adicionar o jogo. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar o jogo: $e');
    }
  }

  // Método para atualizar um jogo
  Future<ApiResponse<Jogo>> updateJogo(Jogo jogo) async {
    try {
      final response = await apiClient.put(
        '${ApiEndpoints.jogo}/${jogo.idJogo}',
        data: jogo.toJson(),
      );
      if (response.statusCode == 200) {
        return ApiResponse.success(Jogo.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao atualizar o jogo. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar o jogo: $e');
    }
  }

  // Método para deletar um jogo
  Future<ApiResponse<void>> deleteJogo(int idJogo) async {
    try {
      final response = await apiClient.delete('${ApiEndpoints.jogo}/$idJogo');
      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar o jogo. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao remover o jogo: $e');
    }
  }
}
