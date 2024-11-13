import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/repositories/jogo_repositories.dart';

class CadastroJogo extends StatefulWidget {
  const CadastroJogo({super.key});

  @override
  CadastroJogoState createState() => CadastroJogoState();
}

class CadastroJogoState extends State<CadastroJogo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeJogoController = TextEditingController();
  final TextEditingController _categoriaJogoController = TextEditingController();
  final TextEditingController _processadorRequeridoController = TextEditingController();
  final TextEditingController _memoriaRAMRequeridaController = TextEditingController();
  final TextEditingController _placaVideoRequeridaController = TextEditingController();
  final TextEditingController _espacoDiscoRequeridoController = TextEditingController();
  final TextEditingController _referenciaImagemJogoController = TextEditingController();
  final JogoRepository _jogoRepository = JogoRepository(ApiClient());

  Future<void> _cadastrarJogo(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      Jogo novoJogo = Jogo(
        nomeJogo: _nomeJogoController.text.trim(),
        categoriaJogo: _categoriaJogoController.text.trim(),
        processadorRequerido: _processadorRequeridoController.text.trim(),
        memoriaRAMRequerida: _memoriaRAMRequeridaController.text.trim(),
        placaVideoRequerida: _placaVideoRequeridaController.text.trim(),
        espacoDiscoRequerido: _espacoDiscoRequeridoController.text.trim(),
        referenciaImagemJogo: _referenciaImagemJogoController.text.trim(),
        data: DateTime.now(),
        ativo: true,
      );

      try {
        final response = await _jogoRepository.addJogo(novoJogo);
        if (response.success) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: const Text('Jogo cadastrado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          navigator.pop();
        } else {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text('Erro ao cadastrar jogo: ${response.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar jogo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Jogo', style: TextStyle(color: Colors.white)),
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
      _buildTextField(_nomeJogoController, 'Nome do Jogo', icon: Icons.videogame_asset),
      const SizedBox(height: 16),
      _buildTextField(_categoriaJogoController, 'Categoria do Jogo', icon: Icons.category),
      const SizedBox(height: 16),
      _buildTextField(_processadorRequeridoController, 'Processador Requerido', icon: Icons.memory),
      const SizedBox(height: 16),
      _buildTextField(_memoriaRAMRequeridaController, 'Memória RAM Requerida', icon: Icons.memory),
      const SizedBox(height: 16),
      _buildTextField(_placaVideoRequeridaController, 'Placa de Vídeo Requerida', icon: Icons.videocam),
      const SizedBox(height: 16),
      _buildTextField(_espacoDiscoRequeridoController, 'Espaço em Disco Requerido', icon: Icons.storage),
      const SizedBox(height: 16),
      _buildTextField(_referenciaImagemJogoController, 'URL da Imagem do Jogo', icon: Icons.image),
      const SizedBox(height: 32),
      ElevatedButton(
        onPressed: () => _cadastrarJogo(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.green,
        ),
        child: const Text('Cadastrar Jogo', style: TextStyle(fontSize: 18)),
      ),
    ];
  }

  TextFormField _buildTextField(
    TextEditingController controller,
    String labelText, {
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
      style: const TextStyle(color: Colors.white),
      inputFormatters: inputFormatters,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo é obrigatório';
        }
        return null;
      },
    );
  }
}
