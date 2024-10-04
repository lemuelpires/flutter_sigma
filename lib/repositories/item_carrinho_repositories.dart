import 'package:flutter_sigma/models/item_carrinho_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemCarrinhoRepository {
  final String baseUrl;

  ItemCarrinhoRepository(this.baseUrl);

  // Método para obter todos os itens de um carrinho
  Future<List<ItemCarrinho>> getItensCarrinho(int idCarrinho) async {
    final response = await http.get(Uri.parse('$baseUrl/item_carrinho?idCarrinho=$idCarrinho'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ItemCarrinho.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar itens do carrinho');
    }
  }

  // Método para adicionar um novo item ao carrinho
  Future<ItemCarrinho> addItemCarrinho(ItemCarrinho itemCarrinho) async {
    final response = await http.post(
      Uri.parse('$baseUrl/item_carrinho'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(itemCarrinho.toJson()),
    );

    if (response.statusCode == 201) {
      return ItemCarrinho.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar item ao carrinho');
    }
  }

  // Método para atualizar um item do carrinho
  Future<ItemCarrinho> updateItemCarrinho(ItemCarrinho itemCarrinho) async {
    final response = await http.put(
      Uri.parse('$baseUrl/item_carrinho/${itemCarrinho.idItemCarrinho}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(itemCarrinho.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemCarrinho.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar item do carrinho');
    }
  }

  // Método para deletar um item do carrinho
  Future<void> deleteItemCarrinho(int idItemCarrinho) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/item_carrinho/$idItemCarrinho'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar item do carrinho');
    }
  }
}
