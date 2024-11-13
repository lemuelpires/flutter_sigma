import 'package:flutter_sigma/models/endereco_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';

class EnderecoRepository {
  final String baseUrl;

  EnderecoRepository(this.baseUrl);

  // Método para obter todos os endereços
  Future<ApiResponse<List<Endereco>>> getEnderecos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/enderecos'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Endereco> enderecos = jsonList.map((json) => Endereco.fromJson(json)).toList();
        return ApiResponse.success(enderecos);
      } else {
        return ApiResponse.error('Falha ao carregar endereços. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar endereços: $e');
    }
  }

  // Método para adicionar um novo endereço
  Future<ApiResponse<Endereco>> addEndereco(Endereco endereco) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/enderecos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(endereco.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(Endereco.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar endereço. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar endereço: $e');
    }
  }

  // Método para atualizar um endereço
  Future<ApiResponse<Endereco>> updateEndereco(Endereco endereco) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/enderecos/${endereco.idEndereco}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(endereco.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(Endereco.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar endereço. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar endereço: $e');
    }
  }

  // Método para deletar um endereço
  Future<ApiResponse<void>> deleteEndereco(int idEndereco) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/enderecos/$idEndereco'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar endereço. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar endereço: $e');
    }
  }
}
