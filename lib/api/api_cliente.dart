/*import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io'; // Import necessário para o HttpClient

class ApiClient {
  late final Dio dio;

  ApiClient({bool useHttps = false}) {
    // Define a base URL com base no uso de HTTPS
    final baseUrl = useHttps
        ? 'https://www.portalmantec.com.br:5002/api/' // HTTPS
        : 'http://www.portalmantec.com.br:5001/api/'; // HTTP

    dio = Dio(BaseOptions(baseUrl: baseUrl));

    // Configura o HttpClient para ignorar certificados inválidos (apenas para HTTPS)
    if (useHttps) {
      dio.httpClientAdapter = IOHttpClientAdapter()
        ..createHttpClient = () {
          final client = HttpClient();
          client.badCertificateCallback = (cert, host, port) => true;
          return client;
        };
    }
  }

  // Método GET
  Future<Response> get(String endpoint) async {
    try {
      return await dio.get(endpoint);
    } catch (e) {
      throw Exception('Erro ao realizar GET: $e');
    }
  }

  // Método GET por ID
  Future<Response> getById(String endpoint, int id) async {
    try {
      return await dio.get('$endpoint/$id');
    } catch (e) {
      throw Exception('Erro ao realizar GET por ID: $e');
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

  // Método DISABLE
  Future<Response> patch(String endpoint) async {
    try {
      return await dio.patch(endpoint);
    } catch (e) {
      throw Exception('Erro ao realizar DISABLE: $e');
    }
  }
}*/
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io'; // Import necessário para o HttpClient

class ApiClient {
  late final Dio dio;

  ApiClient() {
    // Define a base URL diretamente para o ambiente externo
    final baseUrl = 'https://www.portalmantec.com.br/sigma/api/'; // HTTPS

    dio = Dio(BaseOptions(baseUrl: baseUrl));

    // Configura o HttpClient para ignorar certificados inválidos (apenas para HTTPS)
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

  // Método GET por ID
  Future<Response> getById(String endpoint, int id) async {
    try {
      return await dio.get('$endpoint/$id');
    } catch (e) {
      throw Exception('Erro ao realizar GET por ID: $e');
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

  // Método PATCH
  Future<Response> patch(String endpoint) async {
    try {
      return await dio.patch(endpoint);
    } catch (e) {
      throw Exception('Erro ao realizar PATCH: $e');
    }
  }
}
