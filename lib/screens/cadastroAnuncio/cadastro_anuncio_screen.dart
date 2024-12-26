import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/providers/anuncio_providers.dart';
import 'package:flutter_sigma/repositories/anuncio_repositories.dart';
import 'package:flutter_sigma/models/anuncio_model.dart';
import 'package:provider/provider.dart';

class CadastroAnuncio extends StatefulWidget {
  const CadastroAnuncio({super.key});

  @override
  CadastroAnuncioState createState() => CadastroAnuncioState();
}

class CadastroAnuncioState extends State<CadastroAnuncio> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idProdutoController = TextEditingController();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _referenciaImagemController =
      TextEditingController();
  final AnuncioRepository _anuncioRepository = AnuncioRepository(ApiClient());

  Future<void> _cadastrarAnuncio(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      Anuncio novoAnuncio = Anuncio(
        idProduto: int.parse(_idProdutoController.text.trim()),
        titulo: _tituloController.text.trim(),
        descricao: _descricaoController.text.trim(),
        preco: double.parse(_precoController.text.trim()),
        referenciaImagem: _referenciaImagemController.text.trim(),
        data: DateTime.now(),
        ativo: true,
      );

      try {
        final response = await _anuncioRepository.addAnuncio(novoAnuncio);
        if (response.success) {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text('Anúncio cadastrado com sucesso!'),
              duration: Duration(seconds: 3),
            ),
          );
          if (context.mounted) {
            // Atualiza a listagem de anúncios
            await Provider.of<AnuncioProvider>(context, listen: false)
                .loadAnuncios();
            navigator.pop();
          }
        } else {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text('Erro ao cadastrar anúncio: ${response.message}'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar anúncio: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Anúncio',
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
      _buildTextField(_idProdutoController, 'ID do Produto',
          icon: Icons.label,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ]),
      const SizedBox(height: 16),
      _buildTextField(_tituloController, 'Título do Anúncio',
          icon: Icons.title),
      const SizedBox(height: 16),
      _buildTextField(_descricaoController, 'Descrição',
          icon: Icons.description),
      const SizedBox(height: 16),
      _buildTextField(_precoController, 'Preço',
          icon: Icons.attach_money,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ]),
      const SizedBox(height: 16),
      _buildTextField(_referenciaImagemController, 'URL da Imagem',
          icon: Icons.image),
      const SizedBox(height: 32),
      ElevatedButton(
        onPressed: () => _cadastrarAnuncio(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xFF7FFF00),
        ),
        child: const Text('Cadastrar Anúncio', style: TextStyle(fontSize: 18)),
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
        fillColor: Colors.white.withAlpha((0.2 * 255).toInt()),
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
