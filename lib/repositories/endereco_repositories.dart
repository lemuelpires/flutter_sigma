import 'package:flutter_sigma/models/endereco_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnderecoRepository {
  final String baseUrl;

  EnderecoRepository(this.baseUrl);

  // Método para obter todos os endereços
  Future<List<Endereco>> getEnderecos() async {
    final response = await http.get(Uri.parse('$baseUrl/enderecos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Endereco.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar endereços');
    }
  }

  // Método para adicionar um novo endereço
  Future<Endereco> addEndereco(Endereco endereco) async {
    final response = await http.post(
      Uri.parse('$baseUrl/enderecos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(endereco.toJson()),
    );

    if (response.statusCode == 201) {
      return Endereco.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar endereço');
    }
  }

  // Método para atualizar um endereço
  Future<Endereco> updateEndereco(Endereco endereco) async {
    final response = await http.put(
      Uri.parse('$baseUrl/enderecos/${endereco.idEndereco}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(endereco.toJson()),
    );

    if (response.statusCode == 200) {
      return Endereco.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar endereço');
    }
  }

  // Método para deletar um endereço
  Future<void> deleteEndereco(int idEndereco) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/enderecos/$idEndereco'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar endereço');
    }
  }
}
