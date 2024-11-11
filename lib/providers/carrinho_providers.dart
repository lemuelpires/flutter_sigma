import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/carrinho_model.dart';
import 'package:flutter_sigma/repositories/carrinho_repositories.dart';
import 'package:logging/logging.dart';
import 'package:flutter_sigma/api/api_response.dart';

final Logger _logger = Logger('CarrinhoProvider');

class CarrinhoProvider with ChangeNotifier {
  final CarrinhoRepository carrinhoRepository;

  CarrinhoProvider(this.carrinhoRepository);

  List<Carrinho> _carrinhos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Carrinho> get carrinhos => _carrinhos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todos os carrinhos
  Future<void> loadCarrinhos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await carrinhoRepository.getCarrinhos();
      if (response.success) {
        _carrinhos = response.data!;
      } else {
        _errorMessage = response.message;
        _carrinhos = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar carrinhos: $error');
      _errorMessage = 'Erro ao carregar carrinhos: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um novo carrinho
  Future<void> addCarrinho(Carrinho carrinho) async {
    try {
      final response = await carrinhoRepository.addCarrinho(carrinho);
      if (response.success) {
        _carrinhos.add(response.data!);
        notifyListeners();
        _logger.info('Carrinho adicionado com sucesso: ${carrinho.idCarrinho}');
      } else {
        _logger.severe('Erro ao adicionar carrinho: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar carrinho: $error');
    }
  }

  // Método para atualizar um carrinho
  Future<void> updateCarrinho(Carrinho carrinho) async {
    try {
      final response = await carrinhoRepository.updateCarrinho(carrinho);
      if (response.success) {
        final index = _carrinhos.indexWhere((c) => c.idCarrinho == response.data!.idCarrinho);
        if (index != -1) {
          _carrinhos[index] = response.data!; // Atualiza o carrinho na lista
          notifyListeners();
        }
        _logger.info('Carrinho atualizado com sucesso: ${carrinho.idCarrinho}');
      } else {
        _logger.severe('Erro ao atualizar carrinho: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar carrinho: $error');
    }
  }

  // Método para deletar um carrinho
  Future<void> deleteCarrinho(int idCarrinho) async {
    try {
      final response = await carrinhoRepository.deleteCarrinho(idCarrinho);
      if (response.success) {
        _carrinhos.removeWhere((c) => c.idCarrinho == idCarrinho); // Remove da lista
        notifyListeners();
        _logger.info('Carrinho deletado com sucesso: $idCarrinho');
      } else {
        _logger.severe('Erro ao deletar carrinho: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao deletar carrinho: $error');
    }
  }
}
