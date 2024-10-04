import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/usuario_jogo_model.dart';
import 'package:flutter_sigma/repositories/usuario_jogo_repositories.dart';
import 'package:logger/logger.dart';

class AssociacaoUsuarioJogoProvider with ChangeNotifier {
  final AssociacaoUsuarioJogoRepository associacaoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<AssociacaoUsuarioJogo> _associacoes = [];

  AssociacaoUsuarioJogoProvider(this.associacaoRepository);

  List<AssociacaoUsuarioJogo> get associacoes => _associacoes;

  // Método para carregar todas as associações
  Future<void> loadAssociacoes() async {
    try {
      _associacoes = await associacaoRepository.getAssociacoes();
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar associações: $e");
    }
  }

  // Método para adicionar uma nova associação
  Future<void> addAssociacao(AssociacaoUsuarioJogo associacao) async {
    try {
      AssociacaoUsuarioJogo newAssociacao = await associacaoRepository.addAssociacao(associacao);
      _associacoes.add(newAssociacao);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Associação adicionada com sucesso: ${associacao.idAssociacao}");
    } catch (e) {
      logger.e("Erro ao adicionar associação: $e");
    }
  }

  // Método para atualizar uma associação
  Future<void> updateAssociacao(AssociacaoUsuarioJogo associacao) async {
    try {
      AssociacaoUsuarioJogo updatedAssociacao = await associacaoRepository.updateAssociacao(associacao);
      int index = _associacoes.indexWhere((e) => e.idAssociacao == updatedAssociacao.idAssociacao);
      if (index != -1) {
        _associacoes[index] = updatedAssociacao; // Atualiza a associação na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Associação atualizada com sucesso: ${associacao.idAssociacao}");
    } catch (e) {
      logger.e("Erro ao atualizar associação: $e");
    }
  }

  // Método para deletar uma associação
  Future<void> deleteAssociacao(int idAssociacao) async {
    try {
      await associacaoRepository.deleteAssociacao(idAssociacao);
      _associacoes.removeWhere((e) => e.idAssociacao == idAssociacao); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Associação deletada com sucesso: $idAssociacao");
    } catch (e) {
      logger.e("Erro ao deletar associação: $e");
    }
  }
}
