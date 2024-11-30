import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/api/api_cliente.dart';
import 'package:flutter_sigma/repositories/produto_repositories.dart';
import 'package:flutter_sigma/models/produto_model.dart';

class EditarProduto extends StatefulWidget {
  final Product produto;

  const EditarProduto({super.key, required this.produto});

  @override
  EditarProdutoState createState() => EditarProdutoState();
}

class EditarProdutoState extends State<EditarProduto> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeProdutoController;
  late TextEditingController _descricaoProdutoController;
  late TextEditingController _precoController;
  late TextEditingController _quantidadeEstoqueController;
  late TextEditingController _categoriaController;
  late TextEditingController _marcaController;
  late TextEditingController _imagemProdutoController;
  late TextEditingController _fichaTecnicaController;

  final ProductRepository _productRepository = ProductRepository(ApiClient());

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os dados do produto passado
    _nomeProdutoController = TextEditingController(text: widget.produto.nomeProduto);
    _descricaoProdutoController = TextEditingController(text: widget.produto.descricaoProduto);
    _precoController = TextEditingController(text: widget.produto.preco.toString());
    _quantidadeEstoqueController = TextEditingController(text: widget.produto.quantidadeEstoque.toString());
    _categoriaController = TextEditingController(text: widget.produto.categoria);
    _marcaController = TextEditingController(text: widget.produto.marca);
    _imagemProdutoController = TextEditingController(text: widget.produto.imagemProduto);
    _fichaTecnicaController = TextEditingController(text: widget.produto.fichaTecnica);
  }

  Future<void> _atualizarProduto(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      Product produtoAtualizado = Product(
        idProduto: widget.produto.idProduto, // Mantém o idProduto para atualizar
        nomeProduto: _nomeProdutoController.text.trim(),
        descricaoProduto: _descricaoProdutoController.text.trim(),
        preco: double.parse(_precoController.text.trim()),
        quantidadeEstoque: int.parse(_quantidadeEstoqueController.text.trim()),
        categoria: _categoriaController.text.trim(),
        marca: _marcaController.text.trim(),
        imagemProduto: _imagemProdutoController.text.trim(),
        fichaTecnica: _fichaTecnicaController.text.trim(),
        data: DateTime.now(),
        ativo: true, // Pode mudar conforme necessidade
      );

      try {
        final response = await _productRepository.updateProduct(produtoAtualizado);
        if (response.success) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: const Text('Produto atualizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          navigator.pop();
        } else {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text('Erro ao atualizar produto: ${response.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar produto: $e'),
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
        title: const Text('Editar Produto', style: TextStyle(color: Colors.white)),
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
        onPressed: () => _atualizarProduto(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.green,
        ),
        child: const Text('Atualizar Produto', style: TextStyle(fontSize: 18)),
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
