import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/endereco_model.dart';
import 'package:flutter_sigma/repositories/endereco_repositories.dart';
import 'package:logging/logging.dart';
import 'package:flutter_sigma/api/api_response.dart';

final Logger _logger = Logger('EnderecoProvider');

class EnderecoProvider with ChangeNotifier {
  final EnderecoRepository enderecoRepository;

  EnderecoProvider(this.enderecoRepository);

  List<Endereco> _enderecos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Endereco> get enderecos => _enderecos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Método para carregar todos os endereços
  Future<void> loadEnderecos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await enderecoRepository.getEnderecos();
      if (response.success) {
        _enderecos = response.data!;
      } else {
        _errorMessage = response.message;
        _enderecos = [];
      }
    } catch (error) {
      _logger.severe('Erro ao carregar endereços: $error');
      _errorMessage = 'Erro ao carregar endereços: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para adicionar um novo endereço
  Future<void> addEndereco(Endereco endereco) async {
    try {
      final response = await enderecoRepository.addEndereco(endereco);
      if (response.success) {
        _enderecos.add(response.data!);
        notifyListeners();
        _logger.info('Endereço adicionado com sucesso: ${endereco.idEndereco}');
      } else {
        _logger.severe('Erro ao adicionar endereço: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao adicionar endereço: $error');
    }
  }

  // Método para atualizar um endereço
  Future<void> updateEndereco(Endereco endereco) async {
    try {
      final response = await enderecoRepository.updateEndereco(endereco);
      if (response.success) {
        final index = _enderecos.indexWhere((e) => e.idEndereco == response.data!.idEndereco);
        if (index != -1) {
          _enderecos[index] = response.data!; // Atualiza o endereço na lista
          notifyListeners();
        }
        _logger.info('Endereço atualizado com sucesso: ${endereco.idEndereco}');
      } else {
        _logger.severe('Erro ao atualizar endereço: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao atualizar endereço: $error');
    }
  }

  // Método para deletar um endereço
  Future<void> deleteEndereco(int idEndereco) async {
    try {
      final response = await enderecoRepository.deleteEndereco(idEndereco);
      if (response.success) {
        _enderecos.removeWhere((e) => e.idEndereco == idEndereco); // Remove da lista
        notifyListeners();
        _logger.info('Endereço deletado com sucesso: $idEndereco');
      } else {
        _logger.severe('Erro ao deletar endereço: ${response.message}');
      }
    } catch (error) {
      _logger.severe('Erro ao deletar endereço: $error');
    }
  }
}
