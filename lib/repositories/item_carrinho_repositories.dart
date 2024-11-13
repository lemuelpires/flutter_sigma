import 'package:flutter_sigma/models/item_carrinho_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';

class ItemCarrinhoRepository {
  final String baseUrl;

  ItemCarrinhoRepository(this.baseUrl);

  // Método para obter todos os itens de um carrinho
  Future<ApiResponse<List<ItemCarrinho>>> getItensCarrinho(int idCarrinho) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/item_carrinho?idCarrinho=$idCarrinho'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<ItemCarrinho> itensCarrinho = jsonList.map((json) => ItemCarrinho.fromJson(json)).toList();
        return ApiResponse.success(itensCarrinho);
      } else {
        return ApiResponse.error('Falha ao carregar itens do carrinho. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar itens do carrinho: $e');
    }
  }

  // Método para adicionar um novo item ao carrinho
  Future<ApiResponse<ItemCarrinho>> addItemCarrinho(ItemCarrinho itemCarrinho) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/item_carrinho'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(itemCarrinho.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(ItemCarrinho.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar item ao carrinho. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar item ao carrinho: $e');
    }
  }

  // Método para atualizar um item do carrinho
  Future<ApiResponse<ItemCarrinho>> updateItemCarrinho(ItemCarrinho itemCarrinho) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/item_carrinho/${itemCarrinho.idItemCarrinho}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(itemCarrinho.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(ItemCarrinho.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar item do carrinho. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar item do carrinho: $e');
    }
  }

  // Método para deletar um item do carrinho
  Future<ApiResponse<void>> deleteItemCarrinho(int idItemCarrinho) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/item_carrinho/$idItemCarrinho'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar item do carrinho. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar item do carrinho: $e');
    }
  }
}
