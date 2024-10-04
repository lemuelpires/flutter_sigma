import 'package:flutter_sigma/models/item_pedido_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemPedidoRepository {
  final String baseUrl;

  ItemPedidoRepository(this.baseUrl);

  // Método para obter todos os itens de um pedido
  Future<List<ItemPedido>> getItensPedido(int idPedido) async {
    final response = await http.get(Uri.parse('$baseUrl/item_pedido?idPedido=$idPedido'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ItemPedido.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar itens do pedido');
    }
  }

  // Método para adicionar um novo item ao pedido
  Future<ItemPedido> addItemPedido(ItemPedido itemPedido) async {
    final response = await http.post(
      Uri.parse('$baseUrl/item_pedido'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(itemPedido.toJson()),
    );

    if (response.statusCode == 201) {
      return ItemPedido.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar item ao pedido');
    }
  }

  // Método para atualizar um item do pedido
  Future<ItemPedido> updateItemPedido(ItemPedido itemPedido) async {
    final response = await http.put(
      Uri.parse('$baseUrl/item_pedido/${itemPedido.idItemPedido}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(itemPedido.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemPedido.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar item do pedido');
    }
  }

  // Método para deletar um item do pedido
  Future<void> deleteItemPedido(int idItemPedido) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/item_pedido/$idItemPedido'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar item do pedido');
    }
  }
}
