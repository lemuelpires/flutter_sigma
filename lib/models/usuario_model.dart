class Usuario {
  int? idUsuario;          // Chave primária autoincrementável
  String email;            // Chave única
  String nome;
  String sobrenome;
  String senha;            // Criptografada
  String genero;
  DateTime dataNascimento;
  String telefone;
  DateTime data;           // Data de criação ou atualização
  String cpf;
  bool ativo;

  Usuario({
    this.idUsuario,        // Pode ser null já que é autoincrementável
    required this.email,
    required this.nome,
    required this.sobrenome,
    required this.senha,
    required this.genero,
    required this.dataNascimento,
    required this.telefone,
    required this.data,
    required this.cpf,
    required this.ativo,
  });

  // Método para converter um objeto JSON em um objeto Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['idUsuario'],
      email: json['email'],
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      senha: json['senha'],                      // Criptografar/descriptografar quando necessário
      genero: json['genero'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
      telefone: json['telefone'],
      data: DateTime.parse(json['data']),
      cpf: json['cpf'],
      ativo: json['ativo'],
    );
  }

  // Método para converter um objeto Usuario em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'email': email,
      'nome': nome,
      'sobrenome': sobrenome,
      'senha': senha,                           // Criptografar antes de armazenar
      'genero': genero,
      'dataNascimento': dataNascimento.toIso8601String(),
      'telefone': telefone,
      'data': data.toIso8601String(),
      'cpf': cpf,
      'ativo': ativo,
    };
  }
}
