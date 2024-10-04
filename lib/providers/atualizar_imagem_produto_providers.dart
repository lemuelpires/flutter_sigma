import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/atualizar_imagem_produto_model.dart';
import 'package:flutter_sigma/repositories/atualizar_imagem_produto_repositories.dart';
import 'package:logger/logger.dart';

class ProdutoProvider with ChangeNotifier {
  final ProdutoRepository produtoRepository;
  final Logger logger = Logger(); // Instância do Logger
  List<Produto> produtos = []; // Suponha que você tenha uma lista de produtos

  ProdutoProvider(this.produtoRepository);

  // Método para atualizar a imagem do produto
  Future<void> updateImagemProduto(int idProduto, String novaImagem) async {
    try {
      Produto updatedProduto = await produtoRepository.updateImagemProduto(idProduto, novaImagem);
      logger.i("Imagem do produto atualizada com sucesso: $idProduto");

      // Aqui você pode atualizar a lista de produtos se necessário
      int index = produtos.indexWhere((p) => p.idProduto == idProduto);
      if (index != -1) {
        produtos[index] = updatedProduto; // Atualiza o produto na lista
      }
      notifyListeners(); // Notifica os ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao atualizar a imagem do produto: $e");
    }
  }
}
