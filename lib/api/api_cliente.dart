import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://localhost:7059/'));

  // Método GET
  Future<Response> get(String endpoint) async {
    try {
      return await dio.get(endpoint);
    } catch (e) {
      // Você pode adicionar um log ou tratamento de erro aqui
      throw Exception('Erro ao realizar GET: $e');
    }
  }

  // Método POST
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await dio.post(endpoint, data: data);
    } catch (e) {
      throw Exception('Erro ao realizar POST: $e');
    }
  }

  // Método PUT
  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await dio.put(endpoint, data: data);
    } catch (e) {
      throw Exception('Erro ao realizar PUT: $e');
    }
  }

  // Método DELETE
  Future<Response> delete(String endpoint) async {
    try {
      return await dio.delete(endpoint);
    } catch (e) {
      throw Exception('Erro ao realizar DELETE: $e');
    }
  }
}
