import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io'; // Import necessário para o HttpClient

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(baseUrl: 'http://www.portalmantec.com.br:5001/api/'));

    dio.httpClientAdapter = IOHttpClientAdapter()
      ..createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
  }

  // Método GET
  Future<Response> get(String endpoint) async {
    try {
      return await dio.get(endpoint);
    } catch (e) {
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
