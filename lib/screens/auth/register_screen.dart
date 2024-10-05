import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/usuario_model.dart';
import 'package:flutter_sigma/services/firebase_auth_service.dart';
import 'package:flutter_sigma/screens/utils/validators.dart'; // Importando um arquivo com as validações

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
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();  // Instância do serviço

  Future<void> _registrarUsuario(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      Usuario novoUsuario = Usuario(
        email: _emailController.text.trim(),
        nome: _nomeController.text.trim(),
        sobrenome: _sobrenomeController.text.trim(),
        senha: _senhaController.text.trim(),
        genero: _generoController.text.trim(),
        dataNascimento: DateTime.parse(_dataNascimentoController.text.trim()),
        telefone: _telefoneController.text.trim(),
        data: DateTime.now(),
        cpf: _cpfController.text.trim(),
        ativo: true,
      );

      try {
        await _authService.registerUser(novoUsuario, _senhaController.text.trim());

        if (mounted) {
          scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Usuário registrado com sucesso!')));
          navigator.pop();  // Retorna à tela de login ou outra tela
        }
      } catch (e) {
        scaffoldMessenger.showSnackBar(SnackBar(content: Text('Erro ao registrar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuário'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: _buildFormFields(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(_emailController, 'E-mail', validator: Validators.email),
      _buildTextField(_nomeController, 'Nome', validator: Validators.notEmpty),
      _buildTextField(_sobrenomeController, 'Sobrenome', validator: Validators.notEmpty),
      _buildTextField(_senhaController, 'Senha', obscureText: true, validator: Validators.senha),
      _buildTextField(_generoController, 'Gênero', validator: Validators.notEmpty),
      _buildTextField(_dataNascimentoController, 'Data de Nascimento (YYYY-MM-DD)', validator: Validators.dataNascimento),
      _buildTextField(_telefoneController, 'Telefone', validator: Validators.telefone),
      _buildTextField(_cpfController, 'CPF', validator: Validators.cpf),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => _registrarUsuario(context),
        child: const Text('Registrar'),
      ),
    ];
  }

  TextFormField _buildTextField(TextEditingController controller, String labelText, {bool obscureText = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
