import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/item_carrinho_model.dart';
import 'package:flutter_sigma/repositories/item_carrinho_repositories.dart';
import 'package:logger/logger.dart';

class ItemCarrinhoProvider with ChangeNotifier {
  final ItemCarrinhoRepository itemCarrinhoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<ItemCarrinho> _itensCarrinho = [];

  ItemCarrinhoProvider(this.itemCarrinhoRepository);

  List<ItemCarrinho> get itensCarrinho => _itensCarrinho;

  // Método para carregar todos os itens de um carrinho
  Future<void> loadItensCarrinho(int idCarrinho) async {
    try {
      _itensCarrinho = await itemCarrinhoRepository.getItensCarrinho(idCarrinho);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar itens do carrinho: $e");
    }
  }

  // Método para adicionar um novo item ao carrinho
  Future<void> addItemCarrinho(ItemCarrinho itemCarrinho) async {
    try {
      ItemCarrinho newItem = await itemCarrinhoRepository.addItemCarrinho(itemCarrinho);
      _itensCarrinho.add(newItem);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Item adicionado ao carrinho com sucesso: ${itemCarrinho.idItemCarrinho}");
    } catch (e) {
      logger.e("Erro ao adicionar item ao carrinho: $e");
    }
  }

  // Método para atualizar um item do carrinho
  Future<void> updateItemCarrinho(ItemCarrinho itemCarrinho) async {
    try {
      ItemCarrinho updatedItem = await itemCarrinhoRepository.updateItemCarrinho(itemCarrinho);
      int index = _itensCarrinho.indexWhere((e) => e.idItemCarrinho == updatedItem.idItemCarrinho);
      if (index != -1) {
        _itensCarrinho[index] = updatedItem; // Atualiza o item na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Item do carrinho atualizado com sucesso: ${itemCarrinho.idItemCarrinho}");
    } catch (e) {
      logger.e("Erro ao atualizar item do carrinho: $e");
    }
  }

  // Método para deletar um item do carrinho
  Future<void> deleteItemCarrinho(int idItemCarrinho) async {
    try {
      await itemCarrinhoRepository.deleteItemCarrinho(idItemCarrinho);
      _itensCarrinho.removeWhere((e) => e.idItemCarrinho == idItemCarrinho); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Item do carrinho deletado com sucesso: $idItemCarrinho");
    } catch (e) {
      logger.e("Erro ao deletar item do carrinho: $e");
    }
  }
}
