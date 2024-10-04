import 'package:flutter_sigma/models/favoritos_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoritoRepository {
  final String baseUrl;

  FavoritoRepository(this.baseUrl);

  // Método para obter todos os favoritos de um usuário
  Future<List<Favorito>> getFavoritos(int idUsuario) async {
    final response = await http.get(Uri.parse('$baseUrl/favoritos?idUsuario=$idUsuario'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Favorito.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar favoritos');
    }
  }

  // Método para adicionar um novo favorito
  Future<Favorito> addFavorito(Favorito favorito) async {
    final response = await http.post(
      Uri.parse('$baseUrl/favoritos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(favorito.toJson()),
    );

    if (response.statusCode == 201) {
      return Favorito.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar favorito');
    }
  }

  // Método para atualizar um favorito
  Future<Favorito> updateFavorito(Favorito favorito) async {
    final response = await http.put(
      Uri.parse('$baseUrl/favoritos/${favorito.idFavorito}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(favorito.toJson()),
    );

    if (response.statusCode == 200) {
      return Favorito.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar favorito');
    }
  }

  // Método para deletar um favorito
  Future<void> deleteFavorito(int idFavorito) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/favoritos/$idFavorito'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar favorito');
    }
  }
}
