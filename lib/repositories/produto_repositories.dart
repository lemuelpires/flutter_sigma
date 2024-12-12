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
        return ApiResponse.error(
            'Falha ao carregar produtos. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao buscar produtos: $e');
    }
  }

  // Método para adicionar um novo produto
  Future<ApiResponse<Product>> addProduct(Product produto) async {
    try {
      final response =
          await apiClient.post(ApiEndpoints.produto, data: produto.toJson());
      if (response.statusCode == 201) {
        return ApiResponse.success(Product.fromJson(response.data));
      } else {
        return ApiResponse.error(
            'Falha ao adicionar produto. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar produto: $e');
    }
  }

  // Método para atualizar um produto existente
  Future<ApiResponse<Product>> updateProduct(Product produto) async {
    try {
      if (produto.idProduto == null) {
        return ApiResponse.error(
            'O idProduto não pode ser nulo para atualização.');
      }

      final response = await apiClient.put(
        '${ApiEndpoints.produto}/${produto.idProduto}',
        data: produto.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResponse.success(produto); // Produto atualizado com sucesso
      } else {
        return ApiResponse.error(
            'Falha ao atualizar produto. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar produto: $e');
    }
  }

  // Método para remover um produto
   Future<ApiResponse<void>> disableProduto(int idProduto) async {
    try {
      final response =
          await apiClient.patch('${ApiEndpoints.produto}/$idProduto/disable');
      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(
            'Falha ao desativar anúncio. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao desativar anúncio: $e');
    }
  }

  // Método para atualizar a imagem de um produto
  Future<ApiResponse<void>> updateProductImage(
      int idProduto, String novaReferenciaImagem) async {
    try {
      final response = await apiClient.put(
        '${ApiEndpoints.produto}/$idProduto/image',
        data: {'imageUrl': novaReferenciaImagem},
      );
      if (response.statusCode == 200) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(
            'Falha ao atualizar imagem do produto. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar imagem do produto: $e');
    }
  }

  // Método para buscar produto por ID
  Future<ApiResponse<Product>> getProductById(int idProduto) async {
    try {
      final response = await apiClient.getById(ApiEndpoints.produto, idProduto);
      if (response.statusCode == 200) {
        return ApiResponse.success(Product.fromJson(response.data));
      } else {
        return ApiResponse.error(
            'Falha ao buscar produto por ID. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao buscar produto por ID: $e');
    }
  }
}