import 'package:flutter_sigma/models/item_pedido_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';

class ItemPedidoRepository {
  final String baseUrl;

  ItemPedidoRepository(this.baseUrl);

  // Método para obter todos os itens de um pedido
  Future<ApiResponse<List<ItemPedido>>> getItensPedido(int idPedido) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/item_pedido?idPedido=$idPedido'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<ItemPedido> itensPedido = jsonList.map((json) => ItemPedido.fromJson(json)).toList();
        return ApiResponse.success(itensPedido);
      } else {
        return ApiResponse.error('Falha ao carregar itens do pedido. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar itens do pedido: $e');
    }
  }

  // Método para adicionar um novo item ao pedido
  Future<ApiResponse<ItemPedido>> addItemPedido(ItemPedido itemPedido) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/item_pedido'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(itemPedido.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(ItemPedido.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar item ao pedido. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar item ao pedido: $e');
    }
  }

  // Método para atualizar um item do pedido
  Future<ApiResponse<ItemPedido>> updateItemPedido(ItemPedido itemPedido) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/item_pedido/${itemPedido.idItemPedido}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(itemPedido.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(ItemPedido.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar item do pedido. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar item do pedido: $e');
    }
  }

  // Método para deletar um item do pedido
  Future<ApiResponse<void>> deleteItemPedido(int idItemPedido) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/item_pedido/$idItemPedido'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar item do pedido. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar item do pedido: $e');
    }
  }
}
