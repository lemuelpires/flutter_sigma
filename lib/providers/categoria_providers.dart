import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/categoria_model.dart';
import 'package:flutter_sigma/repositories/categoria_repositories.dart';
import 'package:logging/logging.dart';
import 'package:flutter_sigma/api/api_response.dart';

final Logger _logger = Logger('CategoriaProvider');

class CategoriaProvider with ChangeNotifier {
  final CategoriaRepository categoriaRepository;

  CategoriaProvider(this.categoriaRepository);

  List<Categoria> _categorias = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Categoria> get categorias => _categorias;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todas as categorias
  Future<void> loadCategorias() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await categoriaRepository.getCategorias();
      if (response.success) {
        _categorias = response.data!;
      } else {
        _errorMessage = response.message;
        _categorias = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar categorias: $error');
      _errorMessage = 'Erro ao carregar categorias: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar uma nova categoria
  Future<void> addCategoria(Categoria categoria) async {
    try {
      final response = await categoriaRepository.addCategoria(categoria);
      if (response.success) {
        _categorias.add(response.data!);
        notifyListeners();
        _logger.info('Categoria adicionada com sucesso: ${categoria.idCategoria}');
      } else {
        _logger.severe('Erro ao adicionar categoria: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar categoria: $error');
    }
  }

  // Método para atualizar uma categoria
  Future<void> updateCategoria(Categoria categoria) async {
    try {
      final response = await categoriaRepository.updateCategoria(categoria);
      if (response.success) {
        final index = _categorias.indexWhere((c) => c.idCategoria == response.data!.idCategoria);
        if (index != -1) {
          _categorias[index] = response.data!; // Atualiza a categoria na lista
          notifyListeners();
        }
        _logger.info('Categoria atualizada com sucesso: ${categoria.idCategoria}');
      } else {
        _logger.severe('Erro ao atualizar categoria: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar categoria: $error');
    }
  }

  // Método para deletar uma categoria
  Future<void> deleteCategoria(int idCategoria) async {
    try {
      final response = await categoriaRepository.deleteCategoria(idCategoria);
      if (response.success) {
        _categorias.removeWhere((c) => c.idCategoria == idCategoria); // Remove da lista
        notifyListeners();
        _logger.info('Categoria deletada com sucesso: $idCategoria');
      } else {
        _logger.severe('Erro ao deletar categoria: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao deletar categoria: $error');
    }
  }
}
