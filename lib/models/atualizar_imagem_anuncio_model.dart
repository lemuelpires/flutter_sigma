class Anuncio {
  int idAnuncio;                         // Chave primária do anúncio
  String? referenciaImagem;              // URL da imagem do anúncio

  Anuncio({
    required this.idAnuncio,
    this.referenciaImagem,
  });

  // Método para converter um objeto JSON em um objeto Anuncio
  factory Anuncio.fromJson(Map<String, dynamic> json) {
    return Anuncio(
      idAnuncio: json['idAnuncio'],
      referenciaImagem: json['referenciaImagem'],
    );
  }

  // Método para converter um objeto Anuncio em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idAnuncio': idAnuncio,
      'referenciaImagem': referenciaImagem,
    };
  }

  // Método para atualizar a imagem do anúncio
  void atualizarImagem(String novaReferencia) {
    referenciaImagem = novaReferencia;
  }
}
