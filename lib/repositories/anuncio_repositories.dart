import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/api/api_endpoints.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/api/api_response.dart';

class AnuncioRepository {
  final ApiClient apiClient;

  AnuncioRepository(this.apiClient);

  // Método para obter todos os anúncios
  Future<ApiResponse<List<Anuncio>>> getAnuncios() async {
    try {
      final response = await apiClient.get(ApiEndpoints.anuncio);
      if (response.statusCode == 200) {
        List data = response.data as List;
        List<Anuncio> anuncios = data.map((e) => Anuncio.fromJson(e)).toList();
        return ApiResponse.success(anuncios);
      } else {
        return ApiResponse.error(
            'Falha ao carregar anúncios. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao buscar anúncios: $e');
    }
  }

  // Método para adicionar um novo anúncio
  Future<ApiResponse<Anuncio>> addAnuncio(Anuncio anuncio) async {
    try {
      final response =
          await apiClient.post(ApiEndpoints.anuncio, data: anuncio.toJson());
      if (response.statusCode == 201) {
        return ApiResponse.success(Anuncio.fromJson(response.data));
      } else {
        return ApiResponse.error(
            'Falha ao adicionar anúncio. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar anúncio: $e');
    }
  }

// Método para atualizar um anúncio existente
  Future<ApiResponse<Anuncio>> updateAnuncio(Anuncio anuncio) async {
    try {
      if (anuncio.idAnuncio == null) {
        return ApiResponse.error(
            'O idAnuncio não pode ser nulo para atualização.');
      }

      // Atualizando o anúncio
      final response = await apiClient.put(
          '${ApiEndpoints.anuncio}/${anuncio.idAnuncio}',
          data: anuncio.toJson());

      // Verifica se o status é 200 ou 204 (sucesso sem conteúdo)
      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResponse.success(
            anuncio); // Retorna o anúncio, pois ele foi atualizado corretamente
      } else {
        return ApiResponse.error(
            'Falha ao atualizar anúncio. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar anúncio: $e');
    }
  }

  // Método para remover um anúncio
  Future<ApiResponse<void>> deleteAnuncio(int idAnuncio) async {
    try {
      final response =
          await apiClient.delete('${ApiEndpoints.anuncio}/$idAnuncio');
      if (response.statusCode == 204) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(
            'Falha ao deletar anúncio. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao remover anúncio: $e');
    }
  }

  // Método para atualizar a imagem de um anúncio
  Future<ApiResponse<void>> updateAnuncioImage(
      int idAnuncio, String novaReferenciaImagem) async {
    try {
      final response = await apiClient.put(
        '${ApiEndpoints.anuncio}/$idAnuncio/image',
        data: {'imageUrl': novaReferenciaImagem},
      );
      if (response.statusCode == 200) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(
            'Falha ao atualizar imagem do anúncio. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar imagem do anúncio: $e');
    }
  }
}
