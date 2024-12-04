import 'package:flutter/foundation.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/repositories/jogo_repositories.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('JogoProvider');

class JogoProvider with ChangeNotifier {
  final JogoRepository jogoRepository;

  JogoProvider(this.jogoRepository);

  List<Jogo> _jogos = [];
  List<Jogo> _filteredJogos = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Jogo> get jogos => _jogos;
  List<Jogo> get filteredJogos => _filteredJogos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Carregar jogos
  Future<void> fetchJogos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await jogoRepository.getJogos();
      if (response.success && response.data != null) {
        _jogos = response.data!;
        _filteredJogos = List.from(_jogos); // Sincroniza as listas
        _logger.info('Jogos carregados com sucesso (${_jogos.length} jogos).');
      } else {
        _errorMessage = response.message ?? 'Erro desconhecido ao carregar jogos.';
        _jogos.clear();
        _filteredJogos.clear();
        _logger.warning('Erro ao carregar jogos: $_errorMessage');
      }
    } catch (error) {
      _errorMessage = 'Erro inesperado: $error';
      _jogos.clear();
      _filteredJogos.clear();
      _logger.severe('Erro ao carregar jogos: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Filtrar jogos
  void filterJogos(String query) {
    if (query.isEmpty) {
      _filteredJogos = List.from(_jogos);
    } else {
      _filteredJogos = _jogos.where((jogo) {
        final lowerQuery = query.toLowerCase();
        return jogo.nomeJogo.toLowerCase().contains(lowerQuery) ||
               jogo.categoriaJogo.toLowerCase().contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }

  // Adicionar jogo
  Future<void> addJogo(Jogo jogo) async {
    try {
      final response = await jogoRepository.addJogo(jogo);
      if (response.success && response.data != null) {
        _jogos.add(response.data!);
        _filteredJogos.add(response.data!);
        _logger.info('Jogo adicionado com sucesso: ${response.data!.nomeJogo}');
        notifyListeners();
      } else {
        _logger.warning('Erro ao adicionar jogo: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar jogo: $error');
    }
  }

  // Atualizar jogo
  Future<void> updateJogo(Jogo jogo) async {
    try {
      final response = await jogoRepository.updateJogo(jogo);
      if (response.success && response.data != null) {
        final index = _jogos.indexWhere((j) => j.idJogo == jogo.idJogo);
        if (index != -1) {
          _jogos[index] = response.data!;
          final filteredIndex = _filteredJogos.indexWhere((j) => j.idJogo == jogo.idJogo);
          if (filteredIndex != -1) {
            _filteredJogos[filteredIndex] = response.data!;
          }
          _logger.info('Jogo atualizado: ${response.data!.nomeJogo}');
          notifyListeners();
        } else {
          _logger.warning('Jogo não encontrado para atualização: ${jogo.idJogo}');
        }
      } else {
        _logger.warning('Erro ao atualizar jogo: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar jogo: $error');
    }
  }

  // Desativar jogo
  Future<void> disableJogo(int idJogo) async {
    try {
      final response = await jogoRepository.disableJogo(idJogo);
      if (response.success) {
        final index = _jogos.indexWhere((j) => j.idJogo == idJogo);
        if (index != -1) {
          _jogos[index] = _jogos[index].copyWith(ativo: false);
          notifyListeners(); // Notifica os ouvintes
          _logger.info("Jogo desativado com sucesso: $idJogo");
        }
      } else {
        _errorMessage = response.message;
        _logger.severe("Erro ao desativar jogo: ${response.message}");
      }
    } catch (e) {
      _errorMessage = 'Erro ao desativar jogo: $e';
      _logger.severe("Erro ao desativar jogo: $e");
    }
  }

  // Método para atualizar um jogo na lista localmente
  void updateJogoInList(Jogo updatedJogo) {
    final index = _jogos.indexWhere((j) => j.idJogo == updatedJogo.idJogo);
    if (index != -1) {
      _jogos[index] = updatedJogo;
      _filteredJogos = List.from(_jogos);
      notifyListeners();
    }
  }
}