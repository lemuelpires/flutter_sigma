import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/avaliacao_model.dart';
import 'package:flutter_sigma/repositories/avaliacao_repositories.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('AvaliacaoProvider');

class AvaliacaoProvider with ChangeNotifier {
  final AvaliacaoRepository avaliacaoRepository;

  AvaliacaoProvider(this.avaliacaoRepository);

  List<Avaliacao> _avaliacoes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Avaliacao> get avaliacoes => _avaliacoes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todas as avaliações
  Future<void> loadAvaliacoes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await avaliacaoRepository.getAvaliacoes();
      if (response.success) {
        _avaliacoes = response.data!;
      } else {
        _errorMessage = response.message;
        _avaliacoes = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar avaliações: $error');
      _errorMessage = 'Erro ao carregar avaliações: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar uma nova avaliação
  Future<void> addAvaliacao(Avaliacao avaliacao) async {
    try {
      final response = await avaliacaoRepository.addAvaliacao(avaliacao);
      if (response.success) {
        _avaliacoes.add(response.data!);
        notifyListeners();
        _logger.info('Avaliação adicionada com sucesso: ${avaliacao.idAvaliacao}');
      } else {
        _logger.severe('Erro ao adicionar avaliação: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar avaliação: $error');
    }
  }

  // Método para atualizar uma avaliação
  Future<void> updateAvaliacao(Avaliacao avaliacao) async {
    try {
      final response = await avaliacaoRepository.updateAvaliacao(avaliacao);
      if (response.success) {
        final index = _avaliacoes.indexWhere((a) => a.idAvaliacao == response.data!.idAvaliacao);
        if (index != -1) {
          _avaliacoes[index] = response.data!; // Atualiza a avaliação na lista
          notifyListeners();
        }
        _logger.info('Avaliação atualizada com sucesso: ${avaliacao.idAvaliacao}');
      } else {
        _logger.severe('Erro ao atualizar avaliação: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar avaliação: $error');
    }
  }

  // Método para deletar uma avaliação
  Future<void> deleteAvaliacao(int idAvaliacao) async {
    try {
      final response = await avaliacaoRepository.deleteAvaliacao(idAvaliacao);
      if (response.success) {
        _avaliacoes.removeWhere((a) => a.idAvaliacao == idAvaliacao); // Remove da lista
        notifyListeners();
        _logger.info('Avaliação deletada com sucesso: $idAvaliacao');
      } else {
        _logger.severe('Erro ao deletar avaliação: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao deletar avaliação: $error');
    }
  }
}
