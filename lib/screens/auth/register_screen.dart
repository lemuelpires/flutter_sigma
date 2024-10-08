import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/models/usuario_model.dart';
import 'package:flutter_sigma/services/firebase_auth_service.dart';
import 'package:flutter_sigma/screens/utils/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // Importando o pacote para máscaras
import 'package:intl/intl.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  RegistroScreenState createState() => RegistroScreenState();
}

class RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  String _generoSelecionado = ''; // Inicialize com valor vazio

  final FirebaseAuthService _authService =
      FirebaseAuthService(); // Instância do serviço

  // Máscaras
  final MaskTextInputFormatter _telefoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final MaskTextInputFormatter _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final MaskTextInputFormatter _dataFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<void> _registrarUsuario(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      Usuario novoUsuario = Usuario(
        email: _emailController.text.trim(),
        nome: _nomeController.text.trim(),
        sobrenome: _sobrenomeController.text.trim(),
        senha: _senhaController.text.trim(),
        genero:
            _generoSelecionado.isEmpty ? 'Não informado' : _generoSelecionado,
        dataNascimento: DateFormat('dd/MM/yyyy').parseStrict(
            _dataNascimentoController.text.trim()), // Parse correto da data
        telefone:
            _telefoneFormatter.getUnmaskedText(), // Remove máscara do telefone
        data: DateTime.now(),
        cpf: _cpfFormatter.getUnmaskedText(), // Remove máscara do CPF
        ativo: true,
      );

      try {
        await _authService.registerUser(
            novoUsuario, _senhaController.text.trim());

        if (mounted) {
          scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text('Usuário registrado com sucesso!')));
          navigator.pop(); // Retorna à tela de login ou outra tela
        }
      } catch (e) {
        scaffoldMessenger
            .showSnackBar(SnackBar(content: Text('Erro ao registrar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuário',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildFormFields(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(
        _emailController,
        'E-mail',
        validator: Validators.email,
        icon: Icons.email,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _nomeController,
        'Nome',
        validator: Validators.notEmpty,
        icon: Icons.person,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _sobrenomeController,
        'Sobrenome',
        validator: Validators.notEmpty,
        icon: Icons.person_outline,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _senhaController,
        'Senha',
        obscureText: true,
        validator: Validators.senha,
        icon: Icons.lock,
      ),
      const SizedBox(height: 16),
      _buildGeneroDropdown(), // Campo para selecionar o gênero
      const SizedBox(height: 16),
      _buildTextField(
        _dataNascimentoController,
        'Data de Nascimento',
        validator: Validators.dataNascimento,
        icon: Icons.calendar_today,
        inputFormatters: [_dataFormatter], // Máscara para data
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _telefoneController,
        'Telefone',
        validator: (value) => Validators.telefone(_telefoneFormatter
            .getUnmaskedText()), // Removendo a máscara para validar o telefone
        icon: Icons.phone,
        inputFormatters: [_telefoneFormatter], // Máscara para telefone
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _cpfController,
        'CPF',
        validator: (value) => Validators.cpf(_cpfFormatter
            .getUnmaskedText()), // Removendo a máscara para validar o CPF
        icon: Icons.account_box,
        inputFormatters: [_cpfFormatter], // Máscara para CPF
      ),
      const SizedBox(height: 32),
      Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7FFF00), Color(0xFF66CC00)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ElevatedButton(
          onPressed: () => _registrarUsuario(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            'Registrar',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    ];
  }

  Widget _buildGeneroDropdown() {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: _generoSelecionado.isEmpty ? null : _generoSelecionado,
        decoration: InputDecoration(
          labelText: 'Gênero',
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(Icons.wc,
              color: Colors.white), // Adiciona o ícone de WC
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        dropdownColor: const Color.fromARGB(255, 70, 69, 69),
        isExpanded: true,
        borderRadius: BorderRadius.circular(30),
        items: const [
          DropdownMenuItem(
            value: '',
            child: Text('Selecione um gênero',
                style: TextStyle(color: Colors.white)),
          ),
          DropdownMenuItem(
            value: 'Masculino',
            child: Row(
              children: [
                SizedBox(width: 10),
                Text('Masculino', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'Feminino',
            child: Row(
              children: [
                SizedBox(width: 10),
                Text('Feminino', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _generoSelecionado = value ?? '';
          });
        },
        itemHeight: 60,
      ),
    );
  }

  TextFormField _buildTextField(
    TextEditingController controller,
    String labelText, {
    bool obscureText = false,
    String? Function(String?)? validator,
    IconData? icon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}
