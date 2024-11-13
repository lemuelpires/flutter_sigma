class Anuncio {
  int? idAnuncio;                       // Chave primária autoincrementável
  int idProduto;                        // Chave estrangeira referenciando a tabela de Produtos
  String titulo;                        // Título do anúncio
  String descricao;                     // Descrição do anúncio
  double preco;                         // Preço do produto
  String referenciaImagem;              // Referência ou URL da imagem do anúncio
  DateTime data;                        // Data do anúncio
  bool ativo;                           // Indica se o anúncio está ativo

  Anuncio({
    this.idAnuncio,                     // Pode ser null, pois é autoincrementável
    required this.idProduto,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.referenciaImagem,
    required this.data,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Anuncio
  factory Anuncio.fromJson(Map<String, dynamic> json) {
    return Anuncio(
      idAnuncio: json['idAnuncio'],
      idProduto: json['idProduto'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      preco: json['preco'].toDouble(),
      referenciaImagem: json['referenciaImagem'],
      data: DateTime.parse(json['data']), // Convertendo string para DateTime
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Anuncio em um objeto JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'idProduto': idProduto,
      'titulo': titulo,
      'descricao': descricao,
      'preco': preco,
      'referenciaImagem': referenciaImagem,
      'data': this.data.toIso8601String(), // Convertendo DateTime para string ISO 8601
      'ativo': ativo,
    };

    // Inclui idAnuncio apenas se não for nulo
    if (idAnuncio != null) {
      data['idAnuncio'] = idAnuncio;
    }

    return data;
  }
}
