class Product {
  int? idProduto;
  String nomeProduto;
  String descricaoProduto;
  double preco;
  int quantidadeEstoque;
  String categoria;
  String marca;
  String imagemProduto;
  String fichaTecnica;
  DateTime data;
  bool ativo;

  Product({
    this.idProduto, // Pode ser null já que é autoincrementável
    required this.nomeProduto,
    required this.descricaoProduto,
    required this.preco,
    required this.quantidadeEstoque,
    required this.categoria,
    required this.marca,
    required this.imagemProduto,
    required this.fichaTecnica,
    required this.data,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idProduto: json['idProduto'],
      nomeProduto: json['nomeProduto'],
      descricaoProduto: json['descricaoProduto'],
      preco: json['preco'].toDouble(),
      quantidadeEstoque: json['quantidadeEstoque'],
      categoria: json['categoria'],
      marca: json['marca'],
      imagemProduto: json['imagemProduto'],
      fichaTecnica: json['fichaTecnica'],
      data: DateTime.parse(json['data']),
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Product em um objeto JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nomeProduto': nomeProduto,
      'descricaoProduto': descricaoProduto,
      'preco': preco,
      'quantidadeEstoque': quantidadeEstoque,
      'categoria': categoria,
      'marca': marca,
      'imagemProduto': imagemProduto,
      'fichaTecnica': fichaTecnica,
      'data': this.data.toIso8601String(),
      'ativo': ativo,
    };

    // Só inclui idProduto se ele não for nulo
    if (idProduto != null) {
      data['idProduto'] = idProduto;
    }

    return data;
  }

  // Método copyWith para criar uma cópia do objeto com algumas propriedades alteradas
  Product copyWith({
    int? idProduto,
    String? nomeProduto,
    String? descricaoProduto,
    double? preco,
    int? quantidadeEstoque,
    String? categoria,
    String? marca,
    String? imagemProduto,
    String? fichaTecnica,
    DateTime? data,
    bool? ativo,
  }) {
    return Product(
      idProduto: idProduto ?? this.idProduto,
      nomeProduto: nomeProduto ?? this.nomeProduto,
      descricaoProduto: descricaoProduto ?? this.descricaoProduto,
      preco: preco ?? this.preco,
      quantidadeEstoque: quantidadeEstoque ?? this.quantidadeEstoque,
      categoria: categoria ?? this.categoria,
      marca: marca ?? this.marca,
      imagemProduto: imagemProduto ?? this.imagemProduto,
      fichaTecnica: fichaTecnica ?? this.fichaTecnica,
      data: data ?? this.data,
      ativo: ativo ?? this.ativo,
    );
  }
}