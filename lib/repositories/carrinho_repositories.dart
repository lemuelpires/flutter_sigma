import 'package:flutter_sigma/models/carrinho_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sigma/api/api_response.dart';

class CarrinhoRepository {
  final String baseUrl;

  CarrinhoRepository(this.baseUrl);

  // Método para obter todos os carrinhos
  Future<ApiResponse<List<Carrinho>>> getCarrinhos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/carrinhos'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Carrinho> carrinhos = jsonList.map((json) => Carrinho.fromJson(json)).toList();
        return ApiResponse.success(carrinhos);
      } else {
        return ApiResponse.error('Falha ao carregar carrinhos. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar carrinhos: $e');
    }
  }

  // Método para adicionar um novo carrinho
  Future<ApiResponse<Carrinho>> addCarrinho(Carrinho carrinho) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/carrinhos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(carrinho.toJson()),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(Carrinho.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao adicionar carrinho. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar carrinho: $e');
    }
  }

  // Método para atualizar um carrinho
  Future<ApiResponse<Carrinho>> updateCarrinho(Carrinho carrinho) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/carrinhos/${carrinho.idCarrinho}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(carrinho.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(Carrinho.fromJson(json.decode(response.body)));
      } else {
        return ApiResponse.error('Falha ao atualizar carrinho. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar carrinho: $e');
    }
  }

  // Método para deletar um carrinho
  Future<ApiResponse<void>> deleteCarrinho(int idCarrinho) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/carrinhos/$idCarrinho'),
      );

      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Falha ao deletar carrinho. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao deletar carrinho: $e');
    }
  }
}
