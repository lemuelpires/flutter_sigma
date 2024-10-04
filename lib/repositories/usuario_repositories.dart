import 'package:flutter_sigma/models/usuario_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioRepository {
  final String baseUrl;

  UsuarioRepository(this.baseUrl);

  // Método para obter todos os usuários
  Future<List<Usuario>> getUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar usuários');
    }
  }

  // Método para obter um usuário pelo ID
  Future<Usuario> getUsuario(int idUsuario) async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios/$idUsuario'));

    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar o usuário');
    }
  }

  // Método para adicionar um novo usuário
  Future<Usuario> addUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );

    if (response.statusCode == 201) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar o usuário');
    }
  }

  // Método para atualizar um usuário
  Future<Usuario> updateUsuario(Usuario usuario) async {
    final response = await http.put(
      Uri.parse('$baseUrl/usuarios/${usuario.idUsuario}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar o usuário');
    }
  }

  // Método para deletar um usuário
  Future<void> deleteUsuario(int idUsuario) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/usuarios/$idUsuario'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar o usuário');
    }
  }
}
