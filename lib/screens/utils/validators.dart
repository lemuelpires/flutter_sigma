import 'package:intl/intl.dart';

class Validators {
  // Validação de e-mail
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o e-mail.';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Por favor, insira um e-mail válido.';
    }
    return null;
  }

  // Validação de campo não vazio
  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo não pode estar vazio.';
    }
    return null;
  }

  // Validação de senha
  static String? senha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a senha.';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return null;
  }

  // Validação de data de nascimento
  static String? dataNascimento(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a data de nascimento.';
    }
    try {
      DateFormat('dd/MM/yyyy').parseStrict(value);
    } catch (e) {
      return 'Data de nascimento inválida. Use o formato dd/MM/yyyy.';
    }
    return null;
  }

  // Validação de telefone
  static String? telefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o telefone.';
    }

    final telefoneSemMascara = value.replaceAll(RegExp(r'[^\d]'), ''); // Remove a máscara (não números)
    
    if (telefoneSemMascara.length < 10 || telefoneSemMascara.length > 11) {
      return 'Por favor, insira um telefone válido (com 10 ou 11 dígitos).';
    }
    return null;
  }

  // Validação de CPF
  static String? cpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o CPF.';
    }

    final cpfSemMascara = value.replaceAll(RegExp(r'[^\d]'), ''); // Remove a máscara (não números)
    
    if (cpfSemMascara.length != 11) {
      return 'Por favor, insira um CPF válido (11 dígitos).';
    }
    return null;
  }
}
