class Produto {
  int idProduto;                     // Chave primária do produto
  String? imagemProduto;             // URL da imagem do produto

  Produto({
    required this.idProduto,
    this.imagemProduto,
  });

  // Método para converter um objeto JSON em um objeto Produto
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      idProduto: json['idProduto'],
      imagemProduto: json['imagemProduto'],
    );
  }

  // Método para converter um objeto Produto em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idProduto': idProduto,
      'imagemProduto': imagemProduto,
    };
  }

  // Método para atualizar a imagem do produto
  void atualizarImagem(String novaReferencia) {
    imagemProduto = novaReferencia;
  }
}
