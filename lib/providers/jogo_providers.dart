import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/repositories/jogo_repositories.dart';
import 'package:logging/logging.dart';
import 'package:flutter_sigma/api/api_response.dart';

final Logger _logger = Logger('JogoProvider');

class JogoProvider with ChangeNotifier {
  final JogoRepository jogoRepository;

  JogoProvider(this.jogoRepository);

  List<Jogo> _jogos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Jogo> get jogos => _jogos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todos os jogos
  Future<void> loadJogos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await jogoRepository.getJogos();
      if (response.success) {
        _jogos = response.data!;
      } else {
        _errorMessage = response.message;
        _jogos = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar jogos: $error');
      _errorMessage = 'Erro ao carregar jogos: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um novo jogo
  Future<void> addJogo(Jogo jogo) async {
    try {
      final response = await jogoRepository.addJogo(jogo);
      if (response.success) {
        _jogos.add(response.data!);
        notifyListeners();
        _logger.info('Jogo adicionado com sucesso: ${jogo.nomeJogo}');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao adicionar jogo: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar jogo: $error');
    }
  }

  // Método para atualizar um jogo
  Future<void> updateJogo(Jogo jogo) async {
    try {
      final response = await jogoRepository.updateJogo(jogo);
      if (response.success) {
        final index = _jogos.indexWhere((e) => e.idJogo == response.data!.idJogo);
        if (index != -1) {
          _jogos[index] = response.data!; // Atualiza o jogo na lista
          notifyListeners();
        }
        _logger.info('Jogo atualizado com sucesso: ${jogo.nomeJogo}');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao atualizar jogo: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar jogo: $error');
    }
  }

  // Método para deletar um jogo
  Future<void> deleteJogo(int idJogo) async {
    try {
      final response = await jogoRepository.deleteJogo(idJogo);
      if (response.success) {
        _jogos.removeWhere((e) => e.idJogo == idJogo); // Remove da lista
        notifyListeners();
        _logger.info('Jogo deletado com sucesso: $idJogo');
      } else {
        _errorMessage = response.message;
        _logger.severe('Erro ao deletar jogo: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao deletar jogo: $error');
    }
  }
}
