import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/repositories/jogo_repositories.dart';
import 'package:logger/logger.dart';

class JogoProvider with ChangeNotifier {
  final JogoRepository jogoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<Jogo> _jogos = [];

  JogoProvider(this.jogoRepository);

  List<Jogo> get jogos => _jogos;

  // Método para carregar todos os jogos
  Future<void> loadJogos() async {
    try {
      _jogos = await jogoRepository.getJogos();
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar jogos: $e");
    }
  }

  // Método para adicionar um novo jogo
  Future<void> addJogo(Jogo jogo) async {
    try {
      Jogo newJogo = await jogoRepository.addJogo(jogo);
      _jogos.add(newJogo);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Jogo adicionado com sucesso: ${jogo.nomeJogo}");
    } catch (e) {
      logger.e("Erro ao adicionar jogo: $e");
    }
  }

  // Método para atualizar um jogo
  Future<void> updateJogo(Jogo jogo) async {
    try {
      Jogo updatedJogo = await jogoRepository.updateJogo(jogo);
      int index = _jogos.indexWhere((e) => e.idJogo == updatedJogo.idJogo);
      if (index != -1) {
        _jogos[index] = updatedJogo; // Atualiza o jogo na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Jogo atualizado com sucesso: ${jogo.nomeJogo}");
    } catch (e) {
      logger.e("Erro ao atualizar jogo: $e");
    }
  }

  // Método para deletar um jogo
  Future<void> deleteJogo(int idJogo) async {
    try {
      await jogoRepository.deleteJogo(idJogo);
      _jogos.removeWhere((e) => e.idJogo == idJogo); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Jogo deletado com sucesso: $idJogo");
    } catch (e) {
      logger.e("Erro ao deletar jogo: $e");
    }
  }
}
