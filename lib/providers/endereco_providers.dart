import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/endereco_model.dart';
import 'package:flutter_sigma/repositories/endereco_repositories.dart';
import 'package:logger/logger.dart';

class EnderecoProvider with ChangeNotifier {
  final EnderecoRepository enderecoRepository;
  final Logger logger = Logger(); // Instância do Logger

  List<Endereco> _enderecos = [];

  EnderecoProvider(this.enderecoRepository);

  List<Endereco> get enderecos => _enderecos;

  // Método para carregar todos os endereços
  Future<void> loadEnderecos() async {
    try {
      _enderecos = await enderecoRepository.getEnderecos();
      notifyListeners(); // Notifica ouvintes para atualizar a interface
    } catch (e) {
      logger.e("Erro ao carregar endereços: $e");
    }
  }

  // Método para adicionar um novo endereço
  Future<void> addEndereco(Endereco endereco) async {
    try {
      Endereco newEndereco = await enderecoRepository.addEndereco(endereco);
      _enderecos.add(newEndereco);
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Endereço adicionado com sucesso: ${endereco.idEndereco}");
    } catch (e) {
      logger.e("Erro ao adicionar endereço: $e");
    }
  }

  // Método para atualizar um endereço
  Future<void> updateEndereco(Endereco endereco) async {
    try {
      Endereco updatedEndereco = await enderecoRepository.updateEndereco(endereco);
      int index = _enderecos.indexWhere((e) => e.idEndereco == updatedEndereco.idEndereco);
      if (index != -1) {
        _enderecos[index] = updatedEndereco; // Atualiza o endereço na lista
        notifyListeners(); // Notifica ouvintes para atualizar a interface
      }
      logger.i("Endereço atualizado com sucesso: ${endereco.idEndereco}");
    } catch (e) {
      logger.e("Erro ao atualizar endereço: $e");
    }
  }

  // Método para deletar um endereço
  Future<void> deleteEndereco(int idEndereco) async {
    try {
      await enderecoRepository.deleteEndereco(idEndereco);
      _enderecos.removeWhere((e) => e.idEndereco == idEndereco); // Remove da lista
      notifyListeners(); // Notifica ouvintes para atualizar a interface
      logger.i("Endereço deletado com sucesso: $idEndereco");
    } catch (e) {
      logger.e("Erro ao deletar endereço: $e");
    }
  }
}
