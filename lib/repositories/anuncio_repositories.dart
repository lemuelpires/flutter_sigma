import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/api/api_endpoints.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';

class AnuncioRepository {
  final ApiClient apiClient;

  AnuncioRepository(this.apiClient);

  // Método para obter todos os anúncios
  Future<List<Anuncio>> getAnuncios() async {
    final response = await apiClient.get(ApiEndpoints.anuncio);
    if (response.statusCode == 200) {
      List data = response.data as List;
      return data.map((e) => Anuncio.fromJson(e)).toList();
    } else {
      throw Exception('Falha ao carregar anúncios');
    }
  }

  // Método para adicionar um novo anúncio
  Future<Anuncio> addAnuncio(Anuncio anuncio) async {
    final response = await apiClient.post(ApiEndpoints.anuncio, data: anuncio.toJson());
    if (response.statusCode == 201) {
      return Anuncio.fromJson(response.data);
    } else {
      throw Exception('Falha ao adicionar anúncio');
    }
  }

  // Método para atualizar um anúncio existente
  Future<Anuncio> updateAnuncio(Anuncio anuncio) async {
    final response = await apiClient.put('${ApiEndpoints.anuncio}/${anuncio.idAnuncio}', data: anuncio.toJson());
    if (response.statusCode == 200) {
      return Anuncio.fromJson(response.data);
    } else {
      throw Exception('Falha ao atualizar anúncio');
    }
  }

  // Método para remover um anúncio
  Future<void> deleteAnuncio(int idAnuncio) async {
    final response = await apiClient.delete('${ApiEndpoints.anuncio}/$idAnuncio');
    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar anúncio');
    }
  }

  updateAnuncioImage(int idAnuncio, String novaReferenciaImagem) {}
}
