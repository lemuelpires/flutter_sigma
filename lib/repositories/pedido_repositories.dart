import 'package:flutter_sigma/models/pedido_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidoRepository {
  final String baseUrl;

  PedidoRepository(this.baseUrl);

  // Método para obter todos os pedidos
  Future<List<Pedido>> getPedidos() async {
    final response = await http.get(Uri.parse('$baseUrl/pedidos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Pedido.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar pedidos');
    }
  }

  // Método para obter um pedido pelo ID
  Future<Pedido> getPedido(int idPedido) async {
    final response = await http.get(Uri.parse('$baseUrl/pedidos/$idPedido'));

    if (response.statusCode == 200) {
      return Pedido.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar o pedido');
    }
  }

  // Método para adicionar um novo pedido
  Future<Pedido> addPedido(Pedido pedido) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pedidos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pedido.toJson()),
    );

    if (response.statusCode == 201) {
      return Pedido.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar o pedido');
    }
  }

  // Método para atualizar um pedido
  Future<Pedido> updatePedido(Pedido pedido) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pedidos/${pedido.idPedido}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pedido.toJson()),
    );

    if (response.statusCode == 200) {
      return Pedido.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar o pedido');
    }
  }

  // Método para deletar um pedido
  Future<void> deletePedido(int idPedido) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/pedidos/$idPedido'),
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar o pedido');
    }
  }
}
