import 'package:flutter_sigma/models/usuario_jogo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssociacaoUsuarioJogoRepository {
  final String baseUrl;

  AssociacaoUsuarioJogoRepository(this.baseUrl);

  // Método para obter todas as associações
  Future<List<AssociacaoUsuarioJogo>> getAssociacoes() async {
    final response = await http.get(Uri.parse('$baseUrl/associacoes'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => AssociacaoUsuarioJogo.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar associações');
    }
  }

  // Método para obter uma associação pelo ID
  Future<AssociacaoUsuarioJogo> getAssociacao(int idAssociacao) async {
    final response = await http.get(Uri.parse('$baseUrl/associacoes/$idAssociacao'));

    if (response.statusCode == 200) {
      return AssociacaoUsuarioJogo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar a associação');
    }
  }

  // Método para adicionar uma nova associação
  Future<AssociacaoUsuarioJogo> addAssociacao(AssociacaoUsuarioJogo associacao) async {
    final response = await http.post(
      Uri.parse('$baseUrl/associacoes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(associacao.toJson()),
    );

    if (response.statusCode == 201) {
      return AssociacaoUsuarioJogo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar a associação');
    }
  }

  // Método para atualizar uma associação
  Future<AssociacaoUsuarioJogo> updateAssociacao(AssociacaoUsuarioJogo associacao) async {
    final response = await http.put(
      Uri.parse('$baseUrl/associacoes/${associacao.idAssociacao}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(associacao.toJson()),
    );

    if (response.statusCode == 200) {
      return AssociacaoUsuarioJogo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar a associação');
    }
  }

  // Método para deletar uma associação
  Future<void> deleteAssociacao(int idAssociacao) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/associacoes/$idAssociacao'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar a associação');
    }
  }
}
