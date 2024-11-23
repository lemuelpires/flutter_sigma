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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                  _emailController,
                  'E-mail',
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _nomeController,
                  'Nome',
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _sobrenomeController,
                  'Sobrenome',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _senhaController,
                  'Senha',
                  obscureText: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _dataNascimentoController,
                  'Data de Nascimento',
                  inputFormatters: [_dataFormatter],
                  icon: Icons.calendar_today,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _telefoneController,
                  'Telefone',
                  inputFormatters: [_telefoneFormatter],
                  icon: Icons.phone,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _cpfController,
                  'CPF',
                  inputFormatters: [_cpfFormatter],
                  icon: Icons.account_box,
                ),
                const SizedBox(height: 16),
                // Campo de Gênero - Radio Buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gênero',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Masculino',
                          groupValue: _generoSelecionado,
                          onChanged: (String? value) {
                            setState(() {
                              _generoSelecionado = value ?? '';
                            });
                          },
                        ),
                        const Text('Masculino'),
                        Radio<String>(
                          value: 'Feminino',
                          groupValue: _generoSelecionado,
                          onChanged: (String? value) {
                            setState(() {
                              _generoSelecionado = value ?? '';
                            });
                          },
                        ),
                        const Text('Feminino'),
                        Radio<String>(
                          value: 'Outro',
                          groupValue: _generoSelecionado,
                          onChanged: (String? value) {
                            setState(() {
                              _generoSelecionado = value ?? '';
                            });
                          },
                        ),
                        const Text('Outro'),
                        Radio<String>(
                          value: 'Não informado',
                          groupValue: _generoSelecionado,
                          onChanged: (String? value) {
                            setState(() {
                              _generoSelecionado = value ?? '';
                            });
                          },
                        ),
                        const Text('Não informado'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Ativo'),
                    Switch(
                      value: ativo,
                      onChanged: (value) {
                        setState(() {
                          ativo = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final usuarioAtualizado = Usuario(
                        idUsuario: widget.usuario.idUsuario,
                        nome: _nomeController.text.trim(),
                        sobrenome: _sobrenomeController.text.trim(),
                        telefone: _telefoneController.text.trim(),
                        email: _emailController.text.trim(),
                        senha: _senhaController.text.trim(),
                        genero: _generoSelecionado.isEmpty
                            ? 'Não informado'
                            : _generoSelecionado,
                        dataNascimento: DateFormat('dd/MM/yyyy').parse(
                          _dataNascimentoController.text.trim(),
                        ),
                        cpf: _cpfController.text.trim(),
                        ativo: ativo,
                        data: DateTime.now(),
                      );

                      // Chama o método de atualização do provider
                      Provider.of<UsuarioProvider>(context, listen: false)
                          .updateUsuario(usuarioAtualizado);

                      Navigator.pop(context); // Voltar para a lista de usuários
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
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
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      inputFormatters: inputFormatters,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label é obrigatório';
        }
        return null;
      },
    );
  }
}
