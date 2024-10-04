import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/carrinho_model.dart';
import 'package:flutter_sigma/repositories/carrinho_repositories.dart';
import 'package:logger/logger.dart';

class CarrinhoProvider with ChangeNotifier {
  final CarrinhoRepository carrinhoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<Carrinho> _carrinhos = [];

  CarrinhoProvider(this.carrinhoRepository);

  List<Carrinho> get carrinhos => _carrinhos;

  // Método para carregar todos os carrinhos
  Future<void> loadCarrinhos() async {
    try {
      _carrinhos = await carrinhoRepository.getCarrinhos();
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar carrinhos: $e");
    }
  }

  // Método para adicionar um novo carrinho
  Future<void> addCarrinho(Carrinho carrinho) async {
    try {
      Carrinho newCarrinho = await carrinhoRepository.addCarrinho(carrinho);
      _carrinhos.add(newCarrinho);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Carrinho adicionado com sucesso: ${carrinho.idCarrinho}");
    } catch (e) {
      logger.e("Erro ao adicionar carrinho: $e");
    }
  }

  // Método para atualizar um carrinho
  Future<void> updateCarrinho(Carrinho carrinho) async {
    try {
      Carrinho updatedCarrinho = await carrinhoRepository.updateCarrinho(carrinho);
      int index = _carrinhos.indexWhere((c) => c.idCarrinho == updatedCarrinho.idCarrinho);
      if (index != -1) {
        _carrinhos[index] = updatedCarrinho; // Atualiza o carrinho na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Carrinho atualizado com sucesso: ${carrinho.idCarrinho}");
    } catch (e) {
      logger.e("Erro ao atualizar carrinho: $e");
    }
  }

  // Método para deletar um carrinho
  Future<void> deleteCarrinho(int idCarrinho) async {
    try {
      await carrinhoRepository.deleteCarrinho(idCarrinho);
      _carrinhos.removeWhere((c) => c.idCarrinho == idCarrinho); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Carrinho deletado com sucesso: $idCarrinho");
    } catch (e) {
      logger.e("Erro ao deletar carrinho: $e");
    }
  }
}
