import 'package:flutter_sigma/models/categoria_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';

class CategoriaRepository {
  final String baseUrl;

  CategoriaRepository(this.baseUrl);

  // Método para obter todas as categorias
  Future<ApiResponse<List<Categoria>>> getCategorias() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categorias'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Categoria> categorias = jsonList.map((json) => Categoria.fromJson(json)).toList();
        return ApiResponse.success(categorias);
      } else {
        return ApiResponse.error('Falha ao carregar categorias. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar categorias: $e');
    }
  }

  // Método para adicionar uma nova categoria
  Future<ApiResponse<Categoria>> addCategoria(Categoria categoria) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/categorias'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(categoria.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(Categoria.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar categoria. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar categoria: $e');
    }
  }

  // Método para atualizar uma categoria
  Future<ApiResponse<Categoria>> updateCategoria(Categoria categoria) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/categorias/${categoria.idCategoria}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(categoria.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(Categoria.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar categoria. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar categoria: $e');
    }
  }

  // Método para deletar uma categoria
  Future<ApiResponse<void>> deleteCategoria(int idCategoria) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/categorias/$idCategoria'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar categoria. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar categoria: $e');
    }
  }
}
