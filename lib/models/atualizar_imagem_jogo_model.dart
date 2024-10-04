class Jogo {
  int idJogo;                         // Chave primária do jogo
  String? referenciaImagemJogo;      // URL da imagem do jogo

  Jogo({
    required this.idJogo,
    this.referenciaImagemJogo,
  });

  // Método para converter um objeto JSON em um objeto Jogo
  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
      idJogo: json['idJogo'],
      referenciaImagemJogo: json['referenciaImagemJogo'],
    );
  }

  // Método para converter um objeto Jogo em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idJogo': idJogo,
      'referenciaImagemJogo': referenciaImagemJogo,
    };
  }

  // Método para atualizar a imagem do jogo
  void atualizarImagem(String novaReferencia) {
    referenciaImagemJogo = novaReferencia;
  }
}
