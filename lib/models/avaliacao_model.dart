class Avaliacao {
  int? idAvaliacao;           // Chave primária autoincrementável
  int idProduto;              // Chave estrangeira referenciando a tabela de Produtos
  int idCliente;              // Chave estrangeira referenciando a tabela de Clientes
  String comentario;          // Comentário em texto da avaliação
  String? urlVideo;           // URL do vídeo opcional
  int classificacao;          // Classificação (por exemplo, de 1 a 5)
  DateTime data;              // Data da avaliação
  bool ativo;                 // Indica se a avaliação está ativa

  Avaliacao({
    this.idAvaliacao,         // Pode ser null já que é autoincrementável
    required this.idProduto,
    required this.idCliente,
    required this.comentario,
    this.urlVideo,
    required this.classificacao,
    required this.data,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Avaliacao
  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      idAvaliacao: json['idAvaliacao'],
      idProduto: json['idProduto'],
      idCliente: json['idCliente'],
      comentario: json['comentario'],
      urlVideo: json['urlVideo'],
      classificacao: json['classificacao'],
      data: DateTime.parse(json['data']),
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Avaliacao em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idAvaliacao': idAvaliacao,
      'idProduto': idProduto,
      'idCliente': idCliente,
      'comentario': comentario,
      'urlVideo': urlVideo,
      'classificacao': classificacao,
      'data': data.toIso8601String(),
      'ativo': ativo,
    };
  }
}
