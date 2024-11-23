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

  @override
  void initState() {
    super.initState();
    _nomeJogoController = TextEditingController(text: widget.jogo.nomeJogo);
    _categoriaJogoController = TextEditingController(text: widget.jogo.categoriaJogo);
    _processadorRequeridoController = TextEditingController(text: widget.jogo.processadorRequerido);
    _memoriaRAMRequeridaController = TextEditingController(text: widget.jogo.memoriaRAMRequerida);
    _placaVideoRequeridaController = TextEditingController(text: widget.jogo.placaVideoRequerida);
    _espacoDiscoRequeridoController = TextEditingController(text: widget.jogo.espacoDiscoRequerido);
    _referenciaImagemJogoController = TextEditingController(text: widget.jogo.referenciaImagemJogo);
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
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      final updatedJogo = Jogo(
        idJogo: widget.jogo.idJogo,
        nomeJogo: _nomeJogoController.text.trim(),
        categoriaJogo: _categoriaJogoController.text.trim(),
        processadorRequerido: _processadorRequeridoController.text.trim(),
        memoriaRAMRequerida: _memoriaRAMRequeridaController.text.trim(),
        placaVideoRequerida: _placaVideoRequeridaController.text.trim(),
        espacoDiscoRequerido: _espacoDiscoRequeridoController.text.trim(),
        referenciaImagemJogo: _referenciaImagemJogoController.text.trim(),
        data: widget.jogo.data,
        ativo: widget.jogo.ativo,
      );

      final jogoProvider = Provider.of<JogoProvider>(context, listen: false);
      await jogoProvider.updateJogo(updatedJogo);

      if (jogoProvider.errorMessage == null) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Jogo atualizado com sucesso!')),
        );
        navigator.pop();
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Erro: ${jogoProvider.errorMessage}')),
        );
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
        _nomeJogoController,
        'Nome do Jogo',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira o nome do jogo';
          }
          return null;
        },
        icon: Icons.gamepad,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _categoriaJogoController,
        'Categoria do Jogo',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira a categoria do jogo';
          }
          return null;
        },
        icon: Icons.category,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _processadorRequeridoController,
        'Processador Requerido',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira o processador requerido';
          }
          return null;
        },
        icon: Icons.computer,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _memoriaRAMRequeridaController,
        'Memória RAM Requerida',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira a memória RAM requerida';
          }
          return null;
        },
        icon: Icons.memory,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _placaVideoRequeridaController,
        'Placa de Vídeo Requerida',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira a placa de vídeo requerida';
          }
          return null;
        },
        icon: Icons.videogame_asset,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _espacoDiscoRequeridoController,
        'Espaço em Disco Requerido',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira o espaço em disco requerido';
          }
          return null;
        },
        icon: Icons.storage,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _referenciaImagemJogoController,
        'Referência da Imagem',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira a referência da imagem';
          }
          return null;
        },
        icon: Icons.image,
      ),
      const SizedBox(height: 16),
      _buildReadOnlyField(
        'Data de Criação',
        widget.jogo.data.toString(),
        icon: Icons.calendar_today,
      ),
      const SizedBox(height: 16),
      SwitchListTile(
        title: const Text('Ativo', style: TextStyle(color: Colors.white)),
        value: widget.jogo.ativo,
        onChanged: (value) {
          setState(() {
            widget.jogo.ativo = value;
          });
        },
        activeColor: Colors.green,
        inactiveThumbColor: Colors.grey,
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
          onPressed: () => _saveChanges(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            'Salvar Alterações',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    ];
  }

  TextFormField _buildTextField(
    TextEditingController controller,
    String labelText, {
    bool obscureText = false,
    String? Function(String?)? validator,
    IconData? icon,
    List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.text,
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
      keyboardType: keyboardType,
    );
  }

  TextFormField _buildReadOnlyField(String labelText, String value, {IconData? icon}) {
    return TextFormField(
      initialValue: value,
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
      enabled: false,
    );
  }
}
