import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/categoria_model.dart';
import 'package:flutter_sigma/repositories/categoria_repositories.dart';
import 'package:logger/logger.dart';

class CategoriaProvider with ChangeNotifier {
  final CategoriaRepository categoriaRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<Categoria> _categorias = [];

  CategoriaProvider(this.categoriaRepository);

  List<Categoria> get categorias => _categorias;

  // Método para carregar todas as categorias
  Future<void> loadCategorias() async {
    try {
      _categorias = await categoriaRepository.getCategorias();
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar categorias: $e");
    }
  }

  // Método para adicionar uma nova categoria
  Future<void> addCategoria(Categoria categoria) async {
    try {
      Categoria newCategoria = await categoriaRepository.addCategoria(categoria);
      _categorias.add(newCategoria);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Categoria adicionada com sucesso: ${categoria.idCategoria}");
    } catch (e) {
      logger.e("Erro ao adicionar categoria: $e");
    }
  }

  // Método para atualizar uma categoria
  Future<void> updateCategoria(Categoria categoria) async {
    try {
      Categoria updatedCategoria = await categoriaRepository.updateCategoria(categoria);
      int index = _categorias.indexWhere((c) => c.idCategoria == updatedCategoria.idCategoria);
      if (index != -1) {
        _categorias[index] = updatedCategoria; // Atualiza a categoria na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Categoria atualizada com sucesso: ${categoria.idCategoria}");
    } catch (e) {
      logger.e("Erro ao atualizar categoria: $e");
    }
  }

  // Método para deletar uma categoria
  Future<void> deleteCategoria(int idCategoria) async {
    try {
      await categoriaRepository.deleteCategoria(idCategoria);
      _categorias.removeWhere((c) => c.idCategoria == idCategoria); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Categoria deletada com sucesso: $idCategoria");
    } catch (e) {
      logger.e("Erro ao deletar categoria: $e");
    }
  }
}
