import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/usuario_jogo_model.dart';
import 'package:flutter_sigma/repositories/usuario_jogo_repositories.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('AssociacaoUsuarioJogoProvider');

class AssociacaoUsuarioJogoProvider with ChangeNotifier {
  final AssociacaoUsuarioJogoRepository associacaoRepository;

  AssociacaoUsuarioJogoProvider(this.associacaoRepository);

  List<AssociacaoUsuarioJogo> _associacoes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<AssociacaoUsuarioJogo> get associacoes => _associacoes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todas as associações
  Future<void> loadAssociacoes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await associacaoRepository.getAssociacoes();
      if (response.success) {
        _associacoes = response.data!;
      } else {
        _errorMessage = response.message;
        _associacoes = [];
      }
    } catch (e) {
      _logger.severe('Erro ao carregar associações: $e');
      _errorMessage = 'Erro ao carregar associações: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar uma nova associação
  Future<void> addAssociacao(AssociacaoUsuarioJogo associacao) async {
    try {
      final response = await associacaoRepository.addAssociacao(associacao);
      if (response.success) {
        _associacoes.add(response.data!);
        notifyListeners();
        _logger.info('Associação adicionada com sucesso: ${associacao.idAssociacao}');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao adicionar associação: ${response.message}');
      }
    } catch (e) {
      _logger.severe('Erro ao adicionar associação: $e');
    }
  }

  // Método para atualizar uma associação
  Future<void> updateAssociacao(AssociacaoUsuarioJogo associacao) async {
    try {
      final response = await associacaoRepository.updateAssociacao(associacao);
      if (response.success) {
        final index = _associacoes.indexWhere((e) => e.idAssociacao == response.data!.idAssociacao);
        if (index != -1) {
          _associacoes[index] = response.data!; // Atualiza a associação na lista
          notifyListeners();
        }
        _logger.info('Associação atualizada com sucesso: ${associacao.idAssociacao}');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao atualizar associação: ${response.message}');
      }
    } catch (e) {
      _logger.severe('Erro ao atualizar associação: $e');
    }
  }

  // Método para deletar uma associação
  Future<void> deleteAssociacao(int idAssociacao) async {
    try {
      final response = await associacaoRepository.deleteAssociacao(idAssociacao);
      if (response.success) {
        _associacoes.removeWhere((e) => e.idAssociacao == idAssociacao); // Remove da lista
        notifyListeners();
        _logger.info('Associação deletada com sucesso: $idAssociacao');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao deletar associação: ${response.message}');
      }
    } catch (e) {
      _logger.severe('Erro ao deletar associação: $e');
    }
  }
}
