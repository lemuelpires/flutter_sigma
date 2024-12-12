import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/providers/jogo_providers.dart';
import 'package:provider/provider.dart';

class EditarJogo extends StatefulWidget {
  final Jogo jogo;

  const EditarJogo({super.key, required this.jogo});

  @override
  EditarJogoState createState() => EditarJogoState();
}

class EditarJogoState extends State<EditarJogo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeJogoController;
  late TextEditingController _categoriaJogoController;
  late TextEditingController _processadorRequeridoController;
  late TextEditingController _memoriaRAMRequeridaController;
  late TextEditingController _placaVideoRequeridaController;
  late TextEditingController _espacoDiscoRequeridoController;
  late TextEditingController _referenciaImagemJogoController;
  late bool ativo;

  @override
  void initState() {
    super.initState();
    _nomeJogoController = TextEditingController(text: widget.jogo.nomeJogo);
    _categoriaJogoController =
        TextEditingController(text: widget.jogo.categoriaJogo);
    _processadorRequeridoController =
        TextEditingController(text: widget.jogo.processadorRequerido);
    _memoriaRAMRequeridaController =
        TextEditingController(text: widget.jogo.memoriaRAMRequerida);
    _placaVideoRequeridaController =
        TextEditingController(text: widget.jogo.placaVideoRequerida);
    _espacoDiscoRequeridoController =
        TextEditingController(text: widget.jogo.espacoDiscoRequerido);
    _referenciaImagemJogoController =
        TextEditingController(text: widget.jogo.referenciaImagemJogo);
    ativo = widget.jogo.ativo;
  }

  @override
  void dispose() {
    _nomeJogoController.dispose();
    _categoriaJogoController.dispose();
    _processadorRequeridoController.dispose();
    _memoriaRAMRequeridaController.dispose();
    _placaVideoRequeridaController.dispose();
    _espacoDiscoRequeridoController.dispose();
    _referenciaImagemJogoController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final updatedJogo = widget.jogo.copyWith(
        nomeJogo: _nomeJogoController.text.trim(),
        categoriaJogo: _categoriaJogoController.text.trim(),
        processadorRequerido: _processadorRequeridoController.text.trim(),
        memoriaRAMRequerida: _memoriaRAMRequeridaController.text.trim(),
        placaVideoRequerida: _placaVideoRequeridaController.text.trim(),
        espacoDiscoRequerido: _espacoDiscoRequeridoController.text.trim(),
        referenciaImagemJogo: _referenciaImagemJogoController.text.trim(),
        ativo: ativo,
      );

      await Provider.of<JogoProvider>(context, listen: false)
          .updateJogo(updatedJogo);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jogo atualizado com sucesso!')),
        );
        Navigator.pop(context, updatedJogo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Jogo', style: TextStyle(color: Colors.white)),
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
                _buildTextField(_nomeJogoController, 'Nome do Jogo',
                    icon: Icons.gamepad),
                const SizedBox(height: 16),
                _buildTextField(_categoriaJogoController, 'Categoria do Jogo',
                    icon: Icons.category),
                const SizedBox(height: 16),
                _buildTextField(
                    _processadorRequeridoController, 'Processador Requerido',
                    icon: Icons.computer),
                const SizedBox(height: 16),
                _buildTextField(
                    _memoriaRAMRequeridaController, 'Memória RAM Requerida',
                    icon: Icons.memory),
                const SizedBox(height: 16),
                _buildTextField(
                    _placaVideoRequeridaController, 'Placa de Vídeo Requerida',
                    icon: Icons.videogame_asset),
                const SizedBox(height: 16),
                _buildTextField(_espacoDiscoRequeridoController,
                    'Espaço em Disco Requerido',
                    icon: Icons.storage),
                const SizedBox(height: 16),
                _buildTextField(
                    _referenciaImagemJogoController, 'Referência da Imagem',
                    icon: Icons.image),
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
                  onPressed: () => _saveChanges(context),
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

  TextFormField _buildTextField(
    TextEditingController controller,
    String labelText, {
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
        labelText: labelText,
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
          return '$labelText é obrigatório';
        }
        return null;
      },
    );
  }
}
