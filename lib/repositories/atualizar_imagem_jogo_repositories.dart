import 'package:dio/dio.dart';
import 'package:flutter_sigma/models/jogo_model.dart';

class JogoRepository {
  final Dio dio; // Instância do Dio

  JogoRepository(this.dio);

  // Método para atualizar a imagem do jogo
  Future<Jogo> updateImagemJogo(int idJogo, String novaReferenciaImagem) async {
    try {
      final response = await dio.patch('/jogos/$idJogo', // Ajuste a URL conforme necessário
        data: {
          'referenciaImagemJogo': novaReferenciaImagem,
        },
      );

      if (response.statusCode == 200) {
        return Jogo.fromJson(response.data);
      } else {
        throw Exception('Falha ao atualizar a imagem do jogo');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar a imagem do jogo: $e');
    }
  }
}
