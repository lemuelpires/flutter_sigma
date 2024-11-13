import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/item_pedido_model.dart';
import 'package:flutter_sigma/repositories/item_pedido_repositories.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('ItemPedidoProvider');

class ItemPedidoProvider with ChangeNotifier {
  final ItemPedidoRepository itemPedidoRepository;

  ItemPedidoProvider(this.itemPedidoRepository);

  List<ItemPedido> _itensPedido = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ItemPedido> get itensPedido => _itensPedido;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todos os itens de um pedido
  Future<void> loadItensPedido(int idPedido) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await itemPedidoRepository.getItensPedido(idPedido);
      if (response.success) {
        _itensPedido = response.data!;
      } else {
        _errorMessage = response.message;
        _itensPedido = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar itens do pedido: $error');
      _errorMessage = 'Erro ao carregar itens do pedido: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um novo item ao pedido
  Future<void> addItemPedido(ItemPedido itemPedido) async {
    try {
      final response = await itemPedidoRepository.addItemPedido(itemPedido);
      if (response.success) {
        _itensPedido.add(response.data!);
        notifyListeners();
        _logger.info('Item adicionado ao pedido com sucesso: ${itemPedido.idItemPedido}');
      } else {
        _logger.severe('Erro ao adicionar item ao pedido: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar item ao pedido: $error');
    }
  }

  // Método para atualizar um item do pedido
  Future<void> updateItemPedido(ItemPedido itemPedido) async {
    try {
      final response = await itemPedidoRepository.updateItemPedido(itemPedido);
      if (response.success) {
        final index = _itensPedido.indexWhere((e) => e.idItemPedido == response.data!.idItemPedido);
        if (index != -1) {
          _itensPedido[index] = response.data!; // Atualiza o item na lista
          notifyListeners();
        }
        _logger.info('Item do pedido atualizado com sucesso: ${itemPedido.idItemPedido}');
      } else {
        _logger.severe('Erro ao atualizar item do pedido: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar item do pedido: $error');
    }
  }

  // Método para deletar um item do pedido
  Future<void> deleteItemPedido(int idItemPedido) async {
    try {
      final response = await itemPedidoRepository.deleteItemPedido(idItemPedido);
      if (response.success) {
        _itensPedido.removeWhere((e) => e.idItemPedido == idItemPedido); // Remove da lista
        notifyListeners();
        _logger.info('Item do pedido deletado com sucesso: $idItemPedido');
      } else {
        _logger.severe('Erro ao deletar item do pedido: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao deletar item do pedido: $error');
    }
  }
}
