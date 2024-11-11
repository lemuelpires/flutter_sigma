import 'package:flutter_sigma/models/avaliacao_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';
import 'package:flutter_sigma/api/api_endpoints.dart';

class AvaliacaoRepository {
  final String baseUrl;

  AvaliacaoRepository(this.baseUrl);

  // Método para obter todas as avaliações
  Future<ApiResponse<List<Avaliacao>>> getAvaliacoes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/avaliacoes'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Avaliacao> avaliacoes = jsonList.map((json) => Avaliacao.fromJson(json)).toList();
        return ApiResponse.success(avaliacoes);
      } else {
        return ApiResponse.error('Falha ao carregar avaliações. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar avaliações: $e');
    }
  }

  // Método para adicionar uma nova avaliação
  Future<ApiResponse<Avaliacao>> addAvaliacao(Avaliacao avaliacao) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/avaliacoes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(avaliacao.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(Avaliacao.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar avaliação. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar avaliação: $e');
    }
  }

  // Método para atualizar uma avaliação
  Future<ApiResponse<Avaliacao>> updateAvaliacao(Avaliacao avaliacao) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/avaliacoes/${avaliacao.idAvaliacao}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(avaliacao.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(Avaliacao.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar avaliação. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar avaliação: $e');
    }
  }

  // Método para deletar uma avaliação
  Future<ApiResponse<void>> deleteAvaliacao(int idAvaliacao) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/avaliacoes/$idAvaliacao'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar avaliação. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar avaliação: $e');
    }
  }
}
