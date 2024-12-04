import 'package:flutter/material.dart';
import 'package:flutter_sigma/api/api_response.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/repositories/produto_repositories.dart';
import 'package:logger/logger.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository productRepository;
  final Logger _logger = Logger();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String? _errorMessage;

  ProductProvider(this.productRepository);

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar produtos
  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final ApiResponse<List<Product>> response = await productRepository.getProducts();
      if (response.success) {
        _products = response.data ?? [];
        _filteredProducts = _products; // Inicializa a lista filtrada
        _logger.i("Produtos carregados com sucesso.");
      } else {
        _errorMessage = response.message ?? 'Erro desconhecido ao buscar produtos';
        _products = [];
        _filteredProducts = [];
        _logger.e("Erro ao buscar produtos: $_errorMessage");
      }
    } catch (error) {
      _errorMessage = 'Erro ao buscar produtos: $error';
      _logger.e("Erro ao buscar produtos: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para filtrar produtos
  void filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_products);
    } else {
      _filteredProducts = _products.where((product) {
        return product.nomeProduto.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // Método para adicionar um produto
  Future<void> addProduct(Product product) async {
    try {
      final ApiResponse<Product> response = await productRepository.addProduct(product);
      if (response.success) {
        _products.add(response.data!);
        _filteredProducts = List.from(_products);
        notifyListeners();
        _logger.i("Produto adicionado com sucesso: ${response.data!.idProduto}");
      } else {
        _errorMessage = response.message;
        _logger.e("Erro ao adicionar produto: $_errorMessage");
      }
    } catch (error) {
      _errorMessage = 'Erro ao adicionar produto: $error';
      _logger.e("Erro ao adicionar produto: $error");
    }
  }

  // Método para atualizar um produto
  Future<void> updateProduct(Product product) async {
    try {
      final ApiResponse<Product> response = await productRepository.updateProduct(product);
      if (response.success) {
        final index = _products.indexWhere((p) => p.idProduto == product.idProduto);
        if (index != -1) {
          _products[index] = response.data!;
          _filteredProducts = List.from(_products);
          notifyListeners();
          _logger.i("Produto atualizado com sucesso: ${response.data!.idProduto}");
        }
      } else {
        _errorMessage = response.message;
        _logger.e("Erro ao atualizar produto: $_errorMessage");
      }
    } catch (error) {
      _errorMessage = 'Erro ao atualizar produto: $error';
      _logger.e("Erro ao atualizar produto: $error");
    }
  }

  // Método para desativar um produto
  Future<void> disableProduct(int idProduto) async {
    try {
      final ApiResponse<void> response = await productRepository.disableProduto(idProduto);
      if (response.success) {
        final index = _products.indexWhere((product) => product.idProduto == idProduto);
        if (index != -1) {
          _products[index] = _products[index].copyWith(ativo: false);
          _filteredProducts = List.from(_products);
          notifyListeners();
          _logger.i("Produto desativado com sucesso: $idProduto");
        }
      } else {
        _errorMessage = response.message;
        _logger.e("Erro ao desativar produto: $_errorMessage");
      }
    } catch (error) {
      _errorMessage = 'Erro ao desativar produto: $error';
      _logger.e("Erro ao desativar produto: $error");
    }
  }

  // Método para atualizar a imagem de um produto
  Future<void> updateProductImage(int idProduto, String imagemProduto) async {
    try {
      final ApiResponse<void> response =
          await productRepository.updateProductImage(idProduto, imagemProduto);
      if (response.success) {
        final index = _products.indexWhere((p) => p.idProduto == idProduto);
        if (index != -1) {
          _products[index] = _products[index].copyWith(imagemProduto: imagemProduto);
          _filteredProducts = List.from(_products);
          notifyListeners();
          _logger.i("Imagem do produto atualizada com sucesso: $idProduto");
        }
      } else {
        _errorMessage = response.message;
        _logger.e("Erro ao atualizar a imagem do produto: $_errorMessage");
      }
    } catch (error) {
      _errorMessage = 'Erro ao atualizar a imagem do produto: $error';
      _logger.e("Erro ao atualizar a imagem do produto: $error");
    }
  }

  // Método para atualizar um produto na lista localmente
  void updateProductInList(Product updatedProduct) {
    final index = _products.indexWhere((p) => p.idProduto == updatedProduct.idProduto);
    if (index != -1) {
      _products[index] = updatedProduct;
      _filteredProducts = List.from(_products);
      notifyListeners();
    }
  }
}