import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/avaliacao_model.dart';
import 'package:flutter_sigma/repositories/avaliacao_repositories.dart';
import 'package:logger/logger.dart';

class AvaliacaoProvider with ChangeNotifier {
  final AvaliacaoRepository avaliacaoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<Avaliacao> _avaliacoes = [];

  AvaliacaoProvider(this.avaliacaoRepository);

  List<Avaliacao> get avaliacoes => _avaliacoes;

  // Método para carregar todas as avaliações
  Future<void> loadAvaliacoes() async {
    try {
      _avaliacoes = await avaliacaoRepository.getAvaliacoes();
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar avaliações: $e");
    }
  }

  // Método para adicionar uma nova avaliação
  Future<void> addAvaliacao(Avaliacao avaliacao) async {
    try {
      Avaliacao newAvaliacao = await avaliacaoRepository.addAvaliacao(avaliacao);
      _avaliacoes.add(newAvaliacao);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Avaliação adicionada com sucesso: ${avaliacao.idAvaliacao}");
    } catch (e) {
      logger.e("Erro ao adicionar avaliação: $e");
    }
  }

  // Método para atualizar uma avaliação
  Future<void> updateAvaliacao(Avaliacao avaliacao) async {
    try {
      Avaliacao updatedAvaliacao = await avaliacaoRepository.updateAvaliacao(avaliacao);
      int index = _avaliacoes.indexWhere((a) => a.idAvaliacao == updatedAvaliacao.idAvaliacao);
      if (index != -1) {
        _avaliacoes[index] = updatedAvaliacao; // Atualiza a avaliação na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Avaliação atualizada com sucesso: ${avaliacao.idAvaliacao}");
    } catch (e) {
      logger.e("Erro ao atualizar avaliação: $e");
    }
  }

  // Método para deletar uma avaliação
  Future<void> deleteAvaliacao(int idAvaliacao) async {
    try {
      await avaliacaoRepository.deleteAvaliacao(idAvaliacao);
      _avaliacoes.removeWhere((a) => a.idAvaliacao == idAvaliacao); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Avaliação deletada com sucesso: $idAvaliacao");
    } catch (e) {
      logger.e("Erro ao deletar avaliação: $e");
    }
  }
}
