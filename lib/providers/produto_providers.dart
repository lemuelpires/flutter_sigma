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

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  // Método para carregar produtos
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await productRepository.getProducts();
    } catch (error) {
      _logger.severe('Erro ao buscar produtos: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um produto
  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await productRepository.addProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (error) {
      _logger.severe('Erro ao adicionar produto: $error');
    }
  }

  // Método para atualizar um produto
  Future<void> updateProduct(Product product) async {
    try {
      final updatedProduct = await productRepository.updateProduct(product);
      final index = _products.indexWhere((p) => p.idProduto == updatedProduct.idProduto);
      if (index != -1) {
        _products[index] = updatedProduct;
        notifyListeners();
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar produto: $error');
    }
  }

  // Método para remover um produto
  Future<void> deleteProduct(int idProduto) async {
    try {
      await productRepository.deleteProduct(idProduto);
      _products.removeWhere((p) => p.idProduto == idProduto);
      notifyListeners();
    } catch (error) {
      _logger.severe('Erro ao remover produto: $error');
    }
  }
}
