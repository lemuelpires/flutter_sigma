import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/pedido_model.dart';
import 'package:flutter_sigma/repositories/pedido_repositories.dart';
import 'package:logger/logger.dart';

class PedidoProvider with ChangeNotifier {
  final PedidoRepository pedidoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<Pedido> _pedidos = [];

  PedidoProvider(this.pedidoRepository);

  List<Pedido> get pedidos => _pedidos;

  // Método para carregar todos os pedidos
  Future<void> loadPedidos() async {
    try {
      _pedidos = await pedidoRepository.getPedidos();
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar pedidos: $e");
    }
  }

  // Método para adicionar um novo pedido
  Future<void> addPedido(Pedido pedido) async {
    try {
      Pedido newPedido = await pedidoRepository.addPedido(pedido);
      _pedidos.add(newPedido);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Pedido adicionado com sucesso: ${pedido.idPedido}");
    } catch (e) {
      logger.e("Erro ao adicionar pedido: $e");
    }
  }

  // Método para atualizar um pedido
  Future<void> updatePedido(Pedido pedido) async {
    try {
      Pedido updatedPedido = await pedidoRepository.updatePedido(pedido);
      int index = _pedidos.indexWhere((e) => e.idPedido == updatedPedido.idPedido);
      if (index != -1) {
        _pedidos[index] = updatedPedido; // Atualiza o pedido na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Pedido atualizado com sucesso: ${pedido.idPedido}");
    } catch (e) {
      logger.e("Erro ao atualizar pedido: $e");
    }
  }

  // Método para deletar um pedido
  Future<void> deletePedido(int idPedido) async {
    try {
      await pedidoRepository.deletePedido(idPedido);
      _pedidos.removeWhere((e) => e.idPedido == idPedido); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Pedido deletado com sucesso: $idPedido");
    } catch (e) {
      logger.e("Erro ao deletar pedido: $e");
    }
  }
}
