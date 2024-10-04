class Endereco {
  int? idEndereco;
  int idCliente;         // Chave estrangeira referenciando a tabela de Clientes
  String rua;
  String numero;
  String bairro;
  String cidade;
  String estado;
  String cep;
  String pais;
  bool ativo;

  Endereco({
    this.idEndereco,      // Pode ser null já que é autoincrementável
    required this.idCliente,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.cep,
    required this.pais,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Endereco
  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      idEndereco: json['idEndereco'],
      idCliente: json['idCliente'],
      rua: json['rua'],
      numero: json['numero'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      cep: json['cep'],
      pais: json['pais'],
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Endereco em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idEndereco': idEndereco,
      'idCliente': idCliente,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'cep': cep,
      'pais': pais,
      'ativo': ativo,
    };
  }
}
