class Favorito {
  int? idFavorito;                        // Chave primária autoincrementável
  int idUsuario;                          // Chave estrangeira referenciando a tabela de Usuários
  int idProduto;                          // Chave estrangeira referenciando a tabela de Produtos
  String imagemProduto;                   // Referência/URL da imagem do produto
  bool ativo;                             // Indica se o favorito está ativo

  Favorito({
    this.idFavorito,                      // Pode ser null, pois é autoincrementável
    required this.idUsuario,
    required this.idProduto,
    required this.imagemProduto,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Favorito
  factory Favorito.fromJson(Map<String, dynamic> json) {
    return Favorito(
      idFavorito: json['idFavorito'],
      idUsuario: json['idUsuario'],
      idProduto: json['idProduto'],
      imagemProduto: json['imagemProduto'],
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Favorito em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idFavorito': idFavorito,
      'idUsuario': idUsuario,
      'idProduto': idProduto,
      'imagemProduto': imagemProduto,
      'ativo': ativo,
    };
  }
}
