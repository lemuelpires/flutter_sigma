import 'package:flutter_sigma/models/atualizar_imagem_produto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdutoRepository {
  final String baseUrl; // URL base da API

  ProdutoRepository(this.baseUrl);

  // Método para atualizar a imagem do produto
  Future<Produto> updateImagemProduto(int idProduto, String novaImagem) async {
    final response = await http.put(
      Uri.parse('$baseUrl/produtos/$idProduto/imagem'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'imagemProduto': novaImagem}),
    );

    if (response.statusCode == 200) {
      // Se a resposta for bem-sucedida, analisa o JSON
      return Produto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar a imagem do produto');
    }
  }
}
