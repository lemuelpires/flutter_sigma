import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JogoRepository {
  final String baseUrl;

  JogoRepository(this.baseUrl);

  // Método para obter todos os jogos
  Future<List<Jogo>> getJogos() async {
    final response = await http.get(Uri.parse('$baseUrl/jogos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Jogo.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar jogos');
    }
  }

  // Método para obter um jogo pelo ID
  Future<Jogo> getJogo(int idJogo) async {
    final response = await http.get(Uri.parse('$baseUrl/jogos/$idJogo'));

    if (response.statusCode == 200) {
      return Jogo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar o jogo');
    }
  }

  // Método para adicionar um novo jogo
  Future<Jogo> addJogo(Jogo jogo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/jogos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jogo.toJson()),
    );

    if (response.statusCode == 201) {
      return Jogo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar o jogo');
    }
  }

  // Método para atualizar um jogo
  Future<Jogo> updateJogo(Jogo jogo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/jogos/${jogo.idJogo}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jogo.toJson()),
    );

    if (response.statusCode == 200) {
      return Jogo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar o jogo');
    }
  }

  // Método para deletar um jogo
  Future<void> deleteJogo(int idJogo) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/jogos/$idJogo'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar o jogo');
    }
  }
}
