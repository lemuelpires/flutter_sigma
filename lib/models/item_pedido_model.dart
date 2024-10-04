class ItemPedido {
  int? idItemPedido;           // Chave primária autoincrementável
  int idPedido;                // Chave estrangeira referenciando a tabela de Pedidos
  int idProduto;               // Chave estrangeira referenciando a tabela de Produtos
  int quantidade;              // Quantidade do produto no pedido
  double precoUnitario;        // Preço unitário do produto
  bool ativo;                  // Indica se o item do pedido está ativo

  ItemPedido({
    this.idItemPedido,         // Pode ser null já que é autoincrementável
    required this.idPedido,
    required this.idProduto,
    required this.quantidade,
    required this.precoUnitario,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto ItemPedido
  factory ItemPedido.fromJson(Map<String, dynamic> json) {
    return ItemPedido(
      idItemPedido: json['idItemPedido'],
      idPedido: json['idPedido'],
      idProduto: json['idProduto'],
      quantidade: json['quantidade'],
      precoUnitario: json['precoUnitario'].toDouble(),
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto ItemPedido em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idItemPedido': idItemPedido,
      'idPedido': idPedido,
      'idProduto': idProduto,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
      'ativo': ativo,
    };
  }
}
