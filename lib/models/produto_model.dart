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
    this.idProduto,              // Pode ser null já que é autoincrementável
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
    return {
      'idProduto': idProduto,
      'nomeProduto': nomeProduto,
      'descricaoProduto': descricaoProduto,
      'preco': preco,
      'quantidadeEstoque': quantidadeEstoque,
      'categoria': categoria,
      'marca': marca,
      'imagemProduto': imagemProduto,
      'fichaTecnica': fichaTecnica,
      'data': data.toIso8601String(),
      'ativo': ativo,
    };
  }
}