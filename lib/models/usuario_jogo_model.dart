class AssociacaoUsuarioJogo {
  int? idAssociacao;                       // Chave primária autoincrementável
  int idUsuario;                            // Chave estrangeira referenciando a tabela de Usuários
  int idJogo;                               // Chave estrangeira referenciando a tabela de Jogos
  String referenciaImagemJogo;              // Referência/URL da imagem do jogo
  bool ativo;                               // Indica se a associação está ativa

  AssociacaoUsuarioJogo({
    this.idAssociacao,                      // Pode ser null, pois é autoincrementável
    required this.idUsuario,
    required this.idJogo,
    required this.referenciaImagemJogo,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto AssociacaoUsuarioJogo
  factory AssociacaoUsuarioJogo.fromJson(Map<String, dynamic> json) {
    return AssociacaoUsuarioJogo(
      idAssociacao: json['idAssociacao'],
      idUsuario: json['idUsuario'],
      idJogo: json['idJogo'],
      referenciaImagemJogo: json['referenciaImagemJogo'],
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto AssociacaoUsuarioJogo em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idAssociacao': idAssociacao,
      'idUsuario': idUsuario,
      'idJogo': idJogo,
      'referenciaImagemJogo': referenciaImagemJogo,
      'ativo': ativo,
    };
  }
}
