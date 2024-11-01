import 'package:flutter_sigma/api/api_cliente.dart'; // Importe o ApiClient
import 'package:flutter_sigma/api/api_endpoints.dart'; // Importe os endpoints da API
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/api/api_response.dart';

class ProductRepository {
  final ApiClient apiClient;

  ProductRepository(this.apiClient);

  // Método para obter todos os produtos
  Future<ApiResponse<List<Product>>> getProducts() async {
    try {
      final response = await apiClient.get(ApiEndpoints.produto);
      if (response.statusCode == 200) {
        List data = response.data as List;
        List<Product> products = data.map((e) => Product.fromJson(e)).toList();
        return ApiResponse.success(products);
      } else {
        return ApiResponse.error('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao buscar produtos: $e');
    }
  }

  // Método para adicionar um novo produto
  Future<ApiResponse<Product>> addProduct(Product produto) async {
    try {
      final response = await apiClient.post(ApiEndpoints.produto, data: produto.toJson());
      if (response.statusCode == 201) {
        return ApiResponse.success(Product.fromJson(response.data));
      } else {
        return ApiResponse.error('Failed to add product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar produto: $e');
    }
  }

  // Método para atualizar um produto existente
  Future<ApiResponse<Product>> updateProduct(Product produto) async {
    try {
      final response = await apiClient.put('${ApiEndpoints.produto}/${produto.idProduto}', data: produto.toJson());
      if (response.statusCode == 200) {
        return ApiResponse.success(Product.fromJson(response.data));
      } else {
        return ApiResponse.error('Failed to update product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar produto: $e');
    }
  }

  // Método para remover um produto
  Future<ApiResponse<void>> deleteProduct(int idProduto) async {
    try {
      final response = await apiClient.delete('${ApiEndpoints.produto}/$idProduto');
      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao remover produto: $e');
    }
  }
}