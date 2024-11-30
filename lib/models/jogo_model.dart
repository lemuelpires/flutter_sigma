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
      idJogo: json['idJogo'] != null ? json['idJogo'] as int : null, // Garantir que idJogo é nulo ou int
      nomeJogo: json['nomeJogo'] ?? '', // Valor padrão caso não esteja presente
      categoriaJogo: json['categoriaJogo'] ?? '', // Valor padrão caso não esteja presente
      processadorRequerido: json['processadorRequerido'] ?? '',
      memoriaRAMRequerida: json['memoriaRAMRequerida'] ?? '',
      placaVideoRequerida: json['placaVideoRequerida'] ?? '',
      espacoDiscoRequerido: json['espacoDiscoRequerido'] ?? '',
      referenciaImagemJogo: json['referenciaImagemJogo'] ?? '',
      data: json['data'] != null ? DateTime.parse(json['data']) : DateTime.now(), // Valor padrão se data estiver ausente
      ativo: json['ativo'] ?? true, // Se ativo não estiver presente, assume como true
    );
  }

  // Método para converter um objeto Jogo em um objeto JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {  // Renomeado para evitar conflito com a variável data
      'nomeJogo': nomeJogo,
      'categoriaJogo': categoriaJogo,
      'processadorRequerido': processadorRequerido,
      'memoriaRAMRequerida': memoriaRAMRequerida,
      'placaVideoRequerida': placaVideoRequerida,
      'espacoDiscoRequerido': espacoDiscoRequerido,
      'referenciaImagemJogo': referenciaImagemJogo,
      'data': data.toIso8601String(), // Converter a data corretamente
      'ativo': ativo,
    };

    // Só inclui idJogo se ele não for nulo
    if (idJogo != null) {
      jsonData['idJogo'] = idJogo;
    }

    return jsonData;
  }
}
