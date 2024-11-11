import 'package:flutter_sigma/models/usuario_jogo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';

class AssociacaoUsuarioJogoRepository {
  final String baseUrl;

  AssociacaoUsuarioJogoRepository(this.baseUrl);

  // Método para obter todas as associações
  Future<ApiResponse<List<AssociacaoUsuarioJogo>>> getAssociacoes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/associacoes'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<AssociacaoUsuarioJogo> associacoes = jsonList.map((json) => AssociacaoUsuarioJogo.fromJson(json)).toList();
        return ApiResponse.success(associacoes);
      } else {
        return ApiResponse.error('Falha ao carregar associações. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar associações: $e');
    }
  }

  // Método para obter uma associação pelo ID
  Future<ApiResponse<AssociacaoUsuarioJogo>> getAssociacao(int idAssociacao) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/associacoes/$idAssociacao'));

      if (response.statusCode == 200) {
        return ApiResponse.success(AssociacaoUsuarioJogo.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao carregar a associação. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar a associação: $e');
    }
  }

  // Método para adicionar uma nova associação
  Future<ApiResponse<AssociacaoUsuarioJogo>> addAssociacao(AssociacaoUsuarioJogo associacao) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/associacoes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(associacao.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(AssociacaoUsuarioJogo.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar a associação. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar a associação: $e');
    }
  }

  // Método para atualizar uma associação
  Future<ApiResponse<AssociacaoUsuarioJogo>> updateAssociacao(AssociacaoUsuarioJogo associacao) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/associacoes/${associacao.idAssociacao}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(associacao.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(AssociacaoUsuarioJogo.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar a associação. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar a associação: $e');
    }
  }

  // Método para deletar uma associação
  Future<ApiResponse<void>> deleteAssociacao(int idAssociacao) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/associacoes/$idAssociacao'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar a associação. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar a associação: $e');
    }
  }
}
