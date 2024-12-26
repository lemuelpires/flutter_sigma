import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:flutter_sigma/providers/anuncio_providers.dart';
import 'package:provider/provider.dart';

class EditarAnuncio extends StatefulWidget {
  final Anuncio anuncio;

  const EditarAnuncio({super.key, required this.anuncio});

  @override
  EditarAnuncioState createState() => EditarAnuncioState();
}

class EditarAnuncioState extends State<EditarAnuncio> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  late TextEditingController _precoController;
  late TextEditingController _referenciaImagemController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.anuncio.titulo);
    _descricaoController = TextEditingController(text: widget.anuncio.descricao);
    _precoController = TextEditingController(text: widget.anuncio.preco.toString());
    _referenciaImagemController = TextEditingController(text: widget.anuncio.referenciaImagem);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _precoController.dispose();
    _referenciaImagemController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      final updatedAnuncio = Anuncio(
        idAnuncio: widget.anuncio.idAnuncio,
        idProduto: widget.anuncio.idProduto,
        titulo: _tituloController.text.trim(),
        descricao: _descricaoController.text.trim(),
        preco: double.tryParse(_precoController.text.trim()) ?? widget.anuncio.preco,
        referenciaImagem: _referenciaImagemController.text.trim(),
        data: widget.anuncio.data,
        ativo: widget.anuncio.ativo,
      );

      final anuncioProvider = Provider.of<AnuncioProvider>(context, listen: false);
      await anuncioProvider.updateAnuncio(updatedAnuncio);

      if (anuncioProvider.errorMessage == null) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Anúncio atualizado com sucesso!')),
        );
        navigator.pop();
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Erro: ${anuncioProvider.errorMessage}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anúncio', style: TextStyle(color: Colors.white)),
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
        _tituloController,
        'Título',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira o título';
          }
          return null;
        },
        icon: Icons.title,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _descricaoController,
        'Descrição',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira a descrição';
          }
          return null;
        },
        icon: Icons.description,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _precoController,
        'Preço',
        validator: (value) {
          if (value == null || double.tryParse(value) == null) {
            return 'Por favor, insira um preço válido';
          }
          return null;
        },
        icon: Icons.attach_money,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        _referenciaImagemController,
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
        widget.anuncio.data.toString(),
        icon: Icons.calendar_today,
      ),
      const SizedBox(height: 16),
      SwitchListTile(
        title: const Text('Ativo', style: TextStyle(color: Colors.white)),
        value: widget.anuncio.ativo,
        onChanged: (value) {
          setState(() {
            widget.anuncio.ativo = value;
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
        fillColor: Colors.white.withAlpha((0.2 * 255).toInt()),
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
        fillColor: Colors.white.withAlpha((0.2 * 255).toInt()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      readOnly: true,
      style: const TextStyle(color: Colors.white),
    );
  }
}
