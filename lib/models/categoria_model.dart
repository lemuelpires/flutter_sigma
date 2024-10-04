class Categoria {
  int? idCategoria;           // Chave primária autoincrementável
  String nomeCategoria;        // Nome da categoria
  int? idCategoriaPai;         // Chave estrangeira referenciando a própria tabela (categoria pai)
  bool ativo;                  // Indica se a categoria está ativa

  Categoria({
    this.idCategoria,          // Pode ser null, pois é autoincrementável
    required this.nomeCategoria,
    this.idCategoriaPai,       // Pode ser null, caso não haja categoria pai
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Categoria
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      idCategoria: json['idCategoria'],
      nomeCategoria: json['nomeCategoria'],
      idCategoriaPai: json['idCategoriaPai'],
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Categoria em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idCategoria': idCategoria,
      'nomeCategoria': nomeCategoria,
      'idCategoriaPai': idCategoriaPai,
      'ativo': ativo,
    };
  }
}
