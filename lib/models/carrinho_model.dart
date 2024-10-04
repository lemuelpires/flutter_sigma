class Carrinho {
  int? idCarrinho;             // Chave primária autoincrementável
  int idCliente;               // Chave estrangeira referenciando a tabela de Clientes
  DateTime dataHoraCriacao;    // Data e hora de criação do carrinho
  bool ativo;                  // Indica se o carrinho está ativo

  Carrinho({
    this.idCarrinho,           // Pode ser null já que é autoincrementável
    required this.idCliente,
    required this.dataHoraCriacao,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Carrinho
  factory Carrinho.fromJson(Map<String, dynamic> json) {
    return Carrinho(
      idCarrinho: json['idCarrinho'],
      idCliente: json['idCliente'],
      dataHoraCriacao: DateTime.parse(json['dataHoraCriacao']),
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Carrinho em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idCarrinho': idCarrinho,
      'idCliente': idCliente,
      'dataHoraCriacao': dataHoraCriacao.toIso8601String(),
      'ativo': ativo,
    };
  }
}
