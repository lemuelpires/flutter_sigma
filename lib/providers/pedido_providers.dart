import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/pedido_model.dart';
import 'package:flutter_sigma/repositories/pedido_repositories.dart';
import 'package:logging/logging.dart';
import 'package:flutter_sigma/api/api_response.dart';

final Logger _logger = Logger('PedidoProvider');

class PedidoProvider with ChangeNotifier {
  final PedidoRepository pedidoRepository;

  PedidoProvider(this.pedidoRepository);

  List<Pedido> _pedidos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Pedido> get pedidos => _pedidos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todos os pedidos
  Future<void> loadPedidos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await pedidoRepository.getPedidos();
      if (response.success) {
        _pedidos = response.data!;
      } else {
        _errorMessage = response.message;
        _pedidos = [];
      }
    } catch (e) {
      _logger.severe('Erro ao carregar pedidos: $e');
      _errorMessage = 'Erro ao carregar pedidos: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um novo pedido
  Future<void> addPedido(Pedido pedido) async {
    try {
      final response = await pedidoRepository.addPedido(pedido);
      if (response.success) {
        _pedidos.add(response.data!);
        notifyListeners();
        _logger.info('Pedido adicionado com sucesso: ${pedido.idPedido}');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao adicionar pedido: ${response.message}');
      }
    } catch (e) {
      _logger.severe('Erro ao adicionar pedido: $e');
    }
  }

  // Método para atualizar um pedido
  Future<void> updatePedido(Pedido pedido) async {
    try {
      final response = await pedidoRepository.updatePedido(pedido);
      if (response.success) {
        final index = _pedidos.indexWhere((e) => e.idPedido == response.data!.idPedido);
        if (index != -1) {
          _pedidos[index] = response.data!; // Atualiza o pedido na lista
          notifyListeners();
        }
        _logger.info('Pedido atualizado com sucesso: ${pedido.idPedido}');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao atualizar pedido: ${response.message}');
      }
    } catch (e) {
      _logger.severe('Erro ao atualizar pedido: $e');
    }
  }

  // Método para deletar um pedido
  Future<void> deletePedido(int idPedido) async {
    try {
      final response = await pedidoRepository.deletePedido(idPedido);
      if (response.success) {
        _pedidos.removeWhere((e) => e.idPedido == idPedido); // Remove da lista
        notifyListeners();
        _logger.info('Pedido deletado com sucesso: $idPedido');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao deletar pedido: ${response.message}');
      }
    } catch (e) {
      _logger.severe('Erro ao deletar pedido: $e');
    }
  }
}
