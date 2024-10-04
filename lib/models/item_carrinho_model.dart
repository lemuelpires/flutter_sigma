class ItemCarrinho {
  int? idItemCarrinho;                   // Chave primária autoincrementável
  int idCarrinho;                         // Chave estrangeira referenciando a tabela de Carrinho de Compras
  int idProduto;                          // Chave estrangeira referenciando a tabela de Produtos
  int quantidade;                         // Quantidade do produto no carrinho
  double precoUnitario;                   // Preço unitário do produto
  String? urlImagem;                     // URL da imagem do produto
  String? descricaoProduto;               // Descrição do produto
  bool ativo;                             // Indica se o item do carrinho está ativo

  ItemCarrinho({
    this.idItemCarrinho,                  // Pode ser null, pois é autoincrementável
    required this.idCarrinho,
    required this.idProduto,
    required this.quantidade,
    required this.precoUnitario,
    this.urlImagem,
    this.descricaoProduto,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto ItemCarrinho
  factory ItemCarrinho.fromJson(Map<String, dynamic> json) {
    return ItemCarrinho(
      idItemCarrinho: json['idItemCarrinho'],
      idCarrinho: json['idCarrinho'],
      idProduto: json['idProduto'],
      quantidade: json['quantidade'],
      precoUnitario: json['precoUnitario'].toDouble(),
      urlImagem: json['urlImagem'],
      descricaoProduto: json['descricaoProduto'],
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto ItemCarrinho em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idItemCarrinho': idItemCarrinho,
      'idCarrinho': idCarrinho,
      'idProduto': idProduto,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
      'urlImagem': urlImagem,
      'descricaoProduto': descricaoProduto,
      'ativo': ativo,
    };
  }
}
