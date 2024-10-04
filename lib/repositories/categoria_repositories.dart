import 'package:flutter_sigma/models/categoria_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriaRepository {
  final String baseUrl;

  CategoriaRepository(this.baseUrl);

  // Método para obter todas as categorias
  Future<List<Categoria>> getCategorias() async {
    final response = await http.get(Uri.parse('$baseUrl/categorias'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Categoria.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar categorias');
    }
  }

  // Método para adicionar uma nova categoria
  Future<Categoria> addCategoria(Categoria categoria) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categorias'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoria.toJson()),
    );

    if (response.statusCode == 201) {
      return Categoria.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar categoria');
    }
  }

  // Método para atualizar uma categoria
  Future<Categoria> updateCategoria(Categoria categoria) async {
    final response = await http.put(
      Uri.parse('$baseUrl/categorias/${categoria.idCategoria}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoria.toJson()),
    );

    if (response.statusCode == 200) {
      return Categoria.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar categoria');
    }
  }

  // Método para deletar uma categoria
  Future<void> deleteCategoria(int idCategoria) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/categorias/$idCategoria'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar categoria');
    }
  }
}
