import 'package:flutter_sigma/models/avaliacao_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AvaliacaoRepository {
  final String baseUrl;

  AvaliacaoRepository(this.baseUrl);

  // Método para obter todas as avaliações
  Future<List<Avaliacao>> getAvaliacoes() async {
    final response = await http.get(Uri.parse('$baseUrl/avaliacoes'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Avaliacao.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar avaliações');
    }
  }

  // Método para adicionar uma nova avaliação
  Future<Avaliacao> addAvaliacao(Avaliacao avaliacao) async {
    final response = await http.post(
      Uri.parse('$baseUrl/avaliacoes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(avaliacao.toJson()),
    );

    if (response.statusCode == 201) {
      return Avaliacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar avaliação');
    }
  }

  // Método para atualizar uma avaliação
  Future<Avaliacao> updateAvaliacao(Avaliacao avaliacao) async {
    final response = await http.put(
      Uri.parse('$baseUrl/avaliacoes/${avaliacao.idAvaliacao}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(avaliacao.toJson()),
    );

    if (response.statusCode == 200) {
      return Avaliacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar avaliação');
    }
  }

  // Método para deletar uma avaliação
  Future<void> deleteAvaliacao(int idAvaliacao) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/avaliacoes/$idAvaliacao'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar avaliação');
    }
  }
}
