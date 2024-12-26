import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/repositories/produto_repositories.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:provider/provider.dart';

class CadastroProduto extends StatefulWidget {
  const CadastroProduto({super.key});

  @override
  CadastroProdutoState createState() => CadastroProdutoState();
}

class CadastroProdutoState extends State<CadastroProduto> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _descricaoProdutoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _quantidadeEstoqueController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _imagemProdutoController = TextEditingController();
  final TextEditingController _fichaTecnicaController = TextEditingController();

  final ProductRepository _productRepository = ProductRepository(ApiClient());
  
  Future<void> _cadastrarProduto(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      Product novoProduto = Product(
        nomeProduto: _nomeProdutoController.text.trim(),
        descricaoProduto: _descricaoProdutoController.text.trim(),
        preco: double.parse(_precoController.text.trim()),
        quantidadeEstoque: int.parse(_quantidadeEstoqueController.text.trim()),
        categoria: _categoriaController.text.trim(),
        marca: _marcaController.text.trim(),
        imagemProduto: _imagemProdutoController.text.trim(),
        fichaTecnica: _fichaTecnicaController.text.trim(),
        data: DateTime.now(),
        ativo: true,
      );

      try {
  final response = await _productRepository.addProduct(novoProduto);
  if (response.success) {
    if (context.mounted) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Produto cadastrado com sucesso!'),
          duration: Duration(seconds: 3),
        ),
      );
      // Atualiza a listagem de produtos
      await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
      navigator.pop();
    }
  } else {
    if (context.mounted) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Erro ao cadastrar produto: ${response.message}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
} catch (e) {
  if (context.mounted) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('Erro ao cadastrar produto: $e'),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto', style: TextStyle(color: Colors.white)),
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
      _buildTextField(_nomeProdutoController, 'Nome do Produto', icon: Icons.label),
      const SizedBox(height: 16),
      _buildTextField(_descricaoProdutoController, 'Descrição', icon: Icons.description),
      const SizedBox(height: 16),
      _buildTextField(_precoController, 'Preço', icon: Icons.attach_money, inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ]),
      const SizedBox(height: 16),
      _buildTextField(_quantidadeEstoqueController, 'Quantidade em Estoque', icon: Icons.storage, inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ]),
      const SizedBox(height: 16),
      _buildTextField(_categoriaController, 'Categoria', icon: Icons.category),
      const SizedBox(height: 16),
      _buildTextField(_marcaController, 'Marca', icon: Icons.branding_watermark),
      const SizedBox(height: 16),
      _buildTextField(_imagemProdutoController, 'URL da Imagem', icon: Icons.image),
      const SizedBox(height: 16),
      _buildTextField(_fichaTecnicaController, 'Ficha Técnica', icon: Icons.article),
      const SizedBox(height: 32),
      ElevatedButton(
        onPressed: () => _cadastrarProduto(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: const Color(0xFF66CC00),
        ),
        child: const Text('Cadastrar Produto', style: TextStyle(fontSize: 18)),
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