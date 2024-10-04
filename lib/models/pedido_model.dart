class Pedido {
  int? idPedido;                // Chave primária autoincrementável
  int idCliente;                // Chave estrangeira referenciando a tabela de Clientes
  DateTime dataPedido;          // Data do pedido
  String statusPedido;          // Status atual do pedido (Ex: Pendente, Enviado, Entregue)
  double totalPedido;           // Valor total do pedido
  String metodoPagamento;       // Método de pagamento (Ex: Cartão, Boleto, etc.)
  String enderecoEntrega;       // Endereço de entrega do pedido
  String detalhesEnvio;         // Detalhes sobre o envio (Ex: Transportadora, código de rastreio)
  DateTime data;                // Data de criação ou última atualização
  bool ativo;                   // Indica se o pedido está ativo

  Pedido({
    this.idPedido,              // Pode ser null já que é autoincrementável
    required this.idCliente,
    required this.dataPedido,
    required this.statusPedido,
    required this.totalPedido,
    required this.metodoPagamento,
    required this.enderecoEntrega,
    required this.detalhesEnvio,
    required this.data,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Pedido
  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      idPedido: json['idPedido'],
      idCliente: json['idCliente'],
      dataPedido: DateTime.parse(json['dataPedido']),
      statusPedido: json['statusPedido'],
      totalPedido: json['totalPedido'].toDouble(),
      metodoPagamento: json['metodoPagamento'],
      enderecoEntrega: json['enderecoEntrega'],
      detalhesEnvio: json['detalhesEnvio'],
      data: DateTime.parse(json['data']),
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Pedido em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idPedido': idPedido,
      'idCliente': idCliente,
      'dataPedido': dataPedido.toIso8601String(),
      'statusPedido': statusPedido,
      'totalPedido': totalPedido,
      'metodoPagamento': metodoPagamento,
      'enderecoEntrega': enderecoEntrega,
      'detalhesEnvio': detalhesEnvio,
      'data': data.toIso8601String(),
      'ativo': ativo,
    };
  }
}
