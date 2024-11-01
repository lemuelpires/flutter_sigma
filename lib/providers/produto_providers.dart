import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/repositories/produto_repositories.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('ProductProvider');

class ProductProvider with ChangeNotifier {
  final ProductRepository productRepository;

  ProductProvider(this.productRepository);

  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar produtos
  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await productRepository.getProducts();
      if (response.success) {
        _products = response.data!;
      } else {
        _errorMessage = response.message;
        _products = [];
      }
    } catch (error) {
      _logger.severe('Erro ao buscar produtos: $error');
      _errorMessage = 'Erro ao buscar produtos: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um produto
  Future<void> addProduct(Product product) async {
    try {
      final response = await productRepository.addProduct(product);
      if (response.success) {
        _products.add(response.data!);
        notifyListeners();
      } else {
        _logger.severe('Erro ao adicionar produto: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar produto: $error');
    }
  }

  // Método para atualizar um produto
  Future<void> updateProduct(Product product) async {
    try {
      final response = await productRepository.updateProduct(product);
      if (response.success) {
        final index = _products.indexWhere((p) => p.idProduto == response.data!.idProduto);
        if (index != -1) {
          _products[index] = response.data!;
          notifyListeners();
        }
      } else {
        _logger.severe('Erro ao atualizar produto: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar produto: $error');
    }
  }

  // Método para remover um produto
  Future<void> deleteProduct(int idProduto) async {
    try {
      final response = await productRepository.deleteProduct(idProduto);
      if (response.success) {
        _products.removeWhere((p) => p.idProduto == idProduto);
        notifyListeners();
      } else {
        _logger.severe('Erro ao remover produto: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao remover produto: $error');
    }
  }
}