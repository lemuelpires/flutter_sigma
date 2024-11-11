import 'package:flutter_sigma/models/pedido_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';

class PedidoRepository {
  final String baseUrl;

  PedidoRepository(this.baseUrl);

  // Método para obter todos os pedidos
  Future<ApiResponse<List<Pedido>>> getPedidos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pedidos'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Pedido> pedidos = jsonList.map((json) => Pedido.fromJson(json)).toList();
        return ApiResponse.success(pedidos);
      } else {
        return ApiResponse.error('Falha ao carregar pedidos. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar pedidos: $e');
    }
  }

  // Método para obter um pedido pelo ID
  Future<ApiResponse<Pedido>> getPedido(int idPedido) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pedidos/$idPedido'));

      if (response.statusCode == 200) {
        return ApiResponse.success(Pedido.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao carregar o pedido. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar o pedido: $e');
    }
  }

  // Método para adicionar um novo pedido
  Future<ApiResponse<Pedido>> addPedido(Pedido pedido) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pedidos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pedido.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(Pedido.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar o pedido. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar o pedido: $e');
    }
  }

  // Método para atualizar um pedido
  Future<ApiResponse<Pedido>> updatePedido(Pedido pedido) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/pedidos/${pedido.idPedido}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pedido.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(Pedido.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar o pedido. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar o pedido: $e');
    }
  }

  // Método para deletar um pedido
  Future<ApiResponse<void>> deletePedido(int idPedido) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/pedidos/$idPedido'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar o pedido. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar o pedido: $e');
    }
  }
}
