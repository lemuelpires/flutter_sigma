import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/item_pedido_model.dart';
import 'package:flutter_sigma/repositories/item_pedido_repositories.dart';
import 'package:logger/logger.dart';

class ItemPedidoProvider with ChangeNotifier {
  final ItemPedidoRepository itemPedidoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<ItemPedido> _itensPedido = [];

  ItemPedidoProvider(this.itemPedidoRepository);

  List<ItemPedido> get itensPedido => _itensPedido;

  // Método para carregar todos os itens de um pedido
  Future<void> loadItensPedido(int idPedido) async {
    try {
      _itensPedido = await itemPedidoRepository.getItensPedido(idPedido);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar itens do pedido: $e");
    }
  }

  // Método para adicionar um novo item ao pedido
  Future<void> addItemPedido(ItemPedido itemPedido) async {
    try {
      ItemPedido newItem = await itemPedidoRepository.addItemPedido(itemPedido);
      _itensPedido.add(newItem);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Item adicionado ao pedido com sucesso: ${itemPedido.idItemPedido}");
    } catch (e) {
      logger.e("Erro ao adicionar item ao pedido: $e");
    }
  }

  // Método para atualizar um item do pedido
  Future<void> updateItemPedido(ItemPedido itemPedido) async {
    try {
      ItemPedido updatedItem = await itemPedidoRepository.updateItemPedido(itemPedido);
      int index = _itensPedido.indexWhere((e) => e.idItemPedido == updatedItem.idItemPedido);
      if (index != -1) {
        _itensPedido[index] = updatedItem; // Atualiza o item na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Item do pedido atualizado com sucesso: ${itemPedido.idItemPedido}");
    } catch (e) {
      logger.e("Erro ao atualizar item do pedido: $e");
    }
  }

  // Método para deletar um item do pedido
  Future<void> deleteItemPedido(int idItemPedido) async {
    try {
      await itemPedidoRepository.deleteItemPedido(idItemPedido);
      _itensPedido.removeWhere((e) => e.idItemPedido == idItemPedido); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Item do pedido deletado com sucesso: $idItemPedido");
    } catch (e) {
      logger.e("Erro ao deletar item do pedido: $e");
    }
  }
}
