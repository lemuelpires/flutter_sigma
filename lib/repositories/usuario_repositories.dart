import 'package:flutter_sigma/api/api_cliente.dart'; // Importa o ApiClient
import 'package:flutter_sigma/api/api_endpoints.dart'; // Importa os endpoints da API
import 'package:flutter_sigma/models/usuario_model.dart';
import 'package:flutter_sigma/api/api_response.dart';

class UsuarioRepository {
  final ApiClient apiClient;

  UsuarioRepository(this.apiClient);

  // Método para obter todos os usuários
  Future<ApiResponse<List<Usuario>>> getUsuarios() async {
    try {
      final response = await apiClient.get(ApiEndpoints.usuario);
      if (response.statusCode == 200) {
        List data = response.data as List;
        List<Usuario> usuarios = data.map((e) => Usuario.fromJson(e)).toList();
        return ApiResponse.success(usuarios);
      } else {
        return ApiResponse.error('Falha ao carregar usuários. Código: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar usuários: $e');
    }
  }

  // Método para obter um usuário pelo ID
  Future<ApiResponse<Usuario>> getUsuario(int idUsuario) async {
    try {
      final response = await apiClient.get('${ApiEndpoints.usuario}/$idUsuario');
      if (response.statusCode == 200) {
        return ApiResponse.success(Usuario.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao carregar o usuário. Código: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao carregar o usuário: $e');
    }
  }

  // Método para adicionar um novo usuário
  Future<ApiResponse<Usuario>> addUsuario(Usuario usuario) async {
    try {
      final response = await apiClient.post(ApiEndpoints.usuario, data: usuario.toJson());
      if (response.statusCode == 201) {
        return ApiResponse.success(Usuario.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao adicionar o usuário. Código: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao adicionar o usuário: $e');
    }
  }

  // Método para atualizar um usuário
  Future<ApiResponse<Usuario>> updateUsuario(Usuario usuario) async {
    try {
      final response = await apiClient.put('${ApiEndpoints.usuario}/${usuario.idUsuario}', data: usuario.toJson());
      if (response.statusCode == 200) {
        return ApiResponse.success(Usuario.fromJson(response.data));
      } else {
        return ApiResponse.error('Falha ao atualizar o usuário. Código: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse.error('Erro ao atualizar o usuário: $e');
    }
  }

  // Método para deletar um usuário
   Future<ApiResponse<void>> disableUsuario(int idUsuario) async {
    try {
      final response =
          await apiClient.patch('${ApiEndpoints.usuario}/$idUsuario/disable');
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
}