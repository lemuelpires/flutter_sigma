 // Importe o modelo Product
import 'package:flutter_sigma/api/api_cliente.dart'; // Importe o ApiClient
import 'package:flutter_sigma/api/api_endpoints.dart'; // Importe os endpoints da API
import 'package:flutter_sigma/models/produto_model.dart';

class ProductRepository {
  final ApiClient apiClient;

  ProductRepository(this.apiClient);

  // Método para obter todos os produtos
  Future<List<Product>> getProducts() async {
    final response = await apiClient.get(ApiEndpoints.produto);
    if (response.statusCode == 200) {
      List data = response.data as List;
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Método para adicionar um novo produto
  Future<Product> addProduct(Product produto) async {
    final response = await apiClient.post(ApiEndpoints.produto, data: produto.toJson());
    if (response.statusCode == 201) {
      return Product.fromJson(response.data);
    } else {
      throw Exception('Failed to add product');
    }
  }

  // Método para atualizar um produto existente
  Future<Product> updateProduct(Product produto) async {
    final response = await apiClient.put('${ApiEndpoints.produto}/${produto.idProduto}', data: produto.toJson());
    if (response.statusCode == 200) {
      return Product.fromJson(response.data);
    } else {
      throw Exception('Failed to update product');
    }
  }

  // Método para remover um produto
  Future<void> deleteProduct(int idProduto) async {
    final response = await apiClient.delete('${ApiEndpoints.produto}/$idProduto');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }
}
