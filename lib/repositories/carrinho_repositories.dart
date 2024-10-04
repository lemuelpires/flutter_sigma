import 'package:flutter_sigma/models/carrinho_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarrinhoRepository {
  final String baseUrl;

  CarrinhoRepository(this.baseUrl);

  // Método para obter todos os carrinhos
  Future<List<Carrinho>> getCarrinhos() async {
    final response = await http.get(Uri.parse('$baseUrl/carrinhos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Carrinho.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar carrinhos');
    }
  }

  // Método para adicionar um novo carrinho
  Future<Carrinho> addCarrinho(Carrinho carrinho) async {
    final response = await http.post(
      Uri.parse('$baseUrl/carrinhos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(carrinho.toJson()),
    );

    if (response.statusCode == 201) {
      return Carrinho.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar carrinho');
    }
  }

  // Método para atualizar um carrinho
  Future<Carrinho> updateCarrinho(Carrinho carrinho) async {
    final response = await http.put(
      Uri.parse('$baseUrl/carrinhos/${carrinho.idCarrinho}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(carrinho.toJson()),
    );

    if (response.statusCode == 200) {
      return Carrinho.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar carrinho');
    }
  }

  // Método para deletar um carrinho
  Future<void> deleteCarrinho(int idCarrinho) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/carrinhos/$idCarrinho'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar carrinho');
    }
  }
}
