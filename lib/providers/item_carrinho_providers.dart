import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/item_carrinho_model.dart';
import 'package:flutter_sigma/repositories/item_carrinho_repositories.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('ItemCarrinhoProvider');

class ItemCarrinhoProvider with ChangeNotifier {
  final ItemCarrinhoRepository itemCarrinhoRepository;

  ItemCarrinhoProvider(this.itemCarrinhoRepository);

  List<ItemCarrinho> _itensCarrinho = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ItemCarrinho> get itensCarrinho => _itensCarrinho;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todos os itens de um carrinho
  Future<void> loadItensCarrinho(int idCarrinho) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await itemCarrinhoRepository.getItensCarrinho(idCarrinho);
      if (response.success) {
        _itensCarrinho = response.data!;
      } else {
        _errorMessage = response.message;
        _itensCarrinho = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar itens do carrinho: $error');
      _errorMessage = 'Erro ao carregar itens do carrinho: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um novo item ao carrinho
  Future<void> addItemCarrinho(ItemCarrinho itemCarrinho) async {
    try {
      final response = await itemCarrinhoRepository.addItemCarrinho(itemCarrinho);
      if (response.success) {
        _itensCarrinho.add(response.data!);
        notifyListeners();
        _logger.info('Item adicionado ao carrinho com sucesso: ${itemCarrinho.idItemCarrinho}');
      } else {
        _logger.severe('Erro ao adicionar item ao carrinho: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar item ao carrinho: $error');
    }
  }

  // Método para atualizar um item do carrinho
  Future<void> updateItemCarrinho(ItemCarrinho itemCarrinho) async {
    try {
      final response = await itemCarrinhoRepository.updateItemCarrinho(itemCarrinho);
      if (response.success) {
        final index = _itensCarrinho.indexWhere((e) => e.idItemCarrinho == response.data!.idItemCarrinho);
        if (index != -1) {
          _itensCarrinho[index] = response.data!; // Atualiza o item na lista
          notifyListeners();
        }
        _logger.info('Item do carrinho atualizado com sucesso: ${itemCarrinho.idItemCarrinho}');
      } else {
        _logger.severe('Erro ao atualizar item do carrinho: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar item do carrinho: $error');
    }
  }

  // Método para deletar um item do carrinho
  Future<void> deleteItemCarrinho(int idItemCarrinho) async {
    try {
      final response = await itemCarrinhoRepository.deleteItemCarrinho(idItemCarrinho);
      if (response.success) {
        _itensCarrinho.removeWhere((e) => e.idItemCarrinho == idItemCarrinho); // Remove da lista
        notifyListeners();
        _logger.info('Item do carrinho deletado com sucesso: $idItemCarrinho');
      } else {
        _logger.severe('Erro ao deletar item do carrinho: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao deletar item do carrinho: $error');
    }
  }
}
