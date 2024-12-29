import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/models/usuario_model.dart';
import 'package:flutter_sigma/providers/usuario_providers.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class EditarUsuario extends StatefulWidget {
  final Usuario usuario;

  const EditarUsuario({super.key, required this.usuario});

  @override
  EditarUsuarioState createState() => EditarUsuarioState();
}

class EditarUsuarioState extends State<EditarUsuario> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _sobrenomeController;
  late TextEditingController _telefoneController;
  late TextEditingController _emailController;
  late TextEditingController _senhaController;
  late TextEditingController _cpfController;
  late TextEditingController _dataNascimentoController;
  late String _generoSelecionado;
  late bool ativo;

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

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.usuario.nome);
    _sobrenomeController =
        TextEditingController(text: widget.usuario.sobrenome);
    _telefoneController = TextEditingController(text: widget.usuario.telefone);
    _emailController = TextEditingController(text: widget.usuario.email);
    _senhaController = TextEditingController(text: widget.usuario.senha);
    _cpfController = TextEditingController(text: widget.usuario.cpf);
    _dataNascimentoController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(widget.usuario.dataNascimento));
    _generoSelecionado = widget.usuario.genero;
    ativo = widget.usuario.ativo;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _cpfController.dispose();
    _dataNascimentoController.dispose();
    super.dispose();
  }

  Future<void> _atualizarUsuario() async {
    if (_formKey.currentState!.validate()) {
      final updatedUsuario = widget.usuario.copyWith(
        nome: _nomeController.text,
        sobrenome: _sobrenomeController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
        senha: _senhaController.text,
        genero: _generoSelecionado,
        dataNascimento:
            DateFormat('dd/MM/yyyy').parse(_dataNascimentoController.text),
        cpf: _cpfController.text,
        ativo: ativo,
        data: DateTime.now(),
      );

      await Provider.of<UsuarioProvider>(context, listen: false)
          .updateUsuario(updatedUsuario);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario atualizado com sucesso!')),
        );
        Navigator.pop(context, updatedUsuario);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Editar Usuário', style: TextStyle(color: Colors.white)),
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
              children: [
                _buildTextField(_emailController, 'E-mail', icon: Icons.email),
                const SizedBox(height: 16),
                _buildTextField(_nomeController, 'Nome', icon: Icons.person),
                const SizedBox(height: 16),
                _buildTextField(_sobrenomeController, 'Sobrenome',
                    icon: Icons.person_outline),
                const SizedBox(height: 16),
                _buildTextField(_senhaController, 'Senha',
                    icon: Icons.lock, obscureText: true),
                const SizedBox(height: 16),
                _buildTextField(_dataNascimentoController, 'Data de Nascimento',
                    icon: Icons.calendar_today,
                    inputFormatters: [_dataFormatter]),
                const SizedBox(height: 16),
                _buildTextField(_telefoneController, 'Telefone',
                    icon: Icons.phone, inputFormatters: [_telefoneFormatter]),
                const SizedBox(height: 16),
                _buildTextField(_cpfController, 'CPF',
                    icon: Icons.account_box, inputFormatters: [_cpfFormatter]),
                const SizedBox(height: 16),
                _buildGeneroRadio(),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Ativo',
                      style: TextStyle(color: Colors.white)),
                  value: ativo,
                  onChanged: (value) {
                    setState(() {
                      ativo = value;
                    });
                  },
                  activeColor: const Color(0xFF66CC00),
                  inactiveThumbColor: Colors.grey,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _atualizarUsuario,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF66CC00)),
                  child: const Text('Salvar',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGeneroRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gênero',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Row(
          children: [
            _buildRadioOption('Masculino'),
            _buildRadioOption('Feminino'),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(String value) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: _generoSelecionado,
            onChanged: (String? selected) {
              setState(() {
                _generoSelecionado = selected ?? '';
              });
            },
          ),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true, // Ativa o preenchimento de cor de fundo
        fillColor: const Color.fromARGB(255, 70, 69, 69), // Cor de fundo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label é obrigatório';
        }
        return null;
      },
    );
  }
}
