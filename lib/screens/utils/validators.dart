import 'package:intl/intl.dart';

class Validators {
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

  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo não pode estar vazio.';
    }
    return null;
  }

  static String? senha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a senha.';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return null;
  }

  static String? dataNascimento(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a data de nascimento.';
    }
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (e) {
      return 'Data de nascimento inválida. Use o formato YYYY-MM-DD.';
    }
    return null;
  }

  static String? telefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o telefone.';
    }
    final regex = RegExp(r'^\+?[0-9]{10,13}$'); // Exemplo de regex para telefone
    if (!regex.hasMatch(value)) {
      return 'Por favor, insira um telefone válido.';
    }
    return null;
  }

  static String? cpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o CPF.';
    }
    final regex = RegExp(r'^\d{11}$'); // CPF deve ter 11 dígitos
    if (!regex.hasMatch(value)) {
      return 'Por favor, insira um CPF válido.';
    }
    return null;
  }
}
