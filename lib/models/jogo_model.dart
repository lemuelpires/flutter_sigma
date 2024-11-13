class Jogo {
  int? idJogo;                     // Chave primária autoincrementável
  String nomeJogo;                 // Nome do jogo
  String categoriaJogo;            // Categoria do jogo (ex: Ação, Aventura)
  String processadorRequerido;     // Requisitos mínimos de processador
  String memoriaRAMRequerida;      // Requisitos mínimos de RAM
  String placaVideoRequerida;      // Requisitos mínimos de placa de vídeo
  String espacoDiscoRequerido;     // Requisitos mínimos de espaço em disco
  String referenciaImagemJogo;     // Referência/URL da imagem do jogo
  DateTime data;                   // Data de criação/lançamento
  bool ativo;                      // Indica se o jogo está ativo

  Jogo({
    this.idJogo,                   // Pode ser null, pois é autoincrementável
    required this.nomeJogo,
    required this.categoriaJogo,
    required this.processadorRequerido,
    required this.memoriaRAMRequerida,
    required this.placaVideoRequerida,
    required this.espacoDiscoRequerido,
    required this.referenciaImagemJogo,
    required this.data,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Jogo
  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
      idJogo: json['idJogo'], 
      nomeJogo: json['nomeJogo'],
      categoriaJogo: json['categoriaJogo'],
      processadorRequerido: json['processadorRequerido'],
      memoriaRAMRequerida: json['memoriaRAMRequerida'],
      placaVideoRequerida: json['placaVideoRequerida'],
      espacoDiscoRequerido: json['espacoDiscoRequerido'],
      referenciaImagemJogo: json['referenciaImagemJogo'],
      data: DateTime.parse(json['data']),
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Jogo em um objeto JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nomeJogo': nomeJogo,
      'categoriaJogo': categoriaJogo,
      'processadorRequerido': processadorRequerido,
      'memoriaRAMRequerida': memoriaRAMRequerida,
      'placaVideoRequerida': placaVideoRequerida,
      'espacoDiscoRequerido': espacoDiscoRequerido,
      'referenciaImagemJogo': referenciaImagemJogo,
      'data': this.data.toIso8601String(), // Corrigido aqui
      'ativo': ativo,
    };

    // Só inclui idJogo se ele não for nulo
    if (idJogo != null) {
      data['idJogo'] = idJogo;
    }

    return data;
  }
}
