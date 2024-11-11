import 'package:flutter_sigma/models/favoritos_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';
import 'package:flutter_sigma/api/api_endpoints.dart';

class FavoritoRepository {
  final String baseUrl;

  FavoritoRepository(this.baseUrl);

  // Método para obter todos os favoritos de um usuário
  Future<ApiResponse<List<Favorito>>> getFavoritos(int idUsuario) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/favoritos?idUsuario=$idUsuario'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Favorito> favoritos = jsonList.map((json) => Favorito.fromJson(json)).toList();
        return ApiResponse.success(favoritos);
      } else {
        return ApiResponse.error('Falha ao carregar favoritos. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar favoritos: $e');
    }
  }

  // Método para adicionar um novo favorito
  Future<ApiResponse<Favorito>> addFavorito(Favorito favorito) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/favoritos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(favorito.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(Favorito.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar favorito. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar favorito: $e');
    }
  }

  // Método para atualizar um favorito
  Future<ApiResponse<Favorito>> updateFavorito(Favorito favorito) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/favoritos/${favorito.idFavorito}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(favorito.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(Favorito.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar favorito. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar favorito: $e');
    }
  }

  // Método para deletar um favorito
  Future<ApiResponse<void>> deleteFavorito(int idFavorito) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/favoritos/$idFavorito'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar favorito. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar favorito: $e');
    }
  }
}
