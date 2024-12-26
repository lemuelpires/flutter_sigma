import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:provider/provider.dart';

class EdicaoProdutoScreen extends StatefulWidget {
  final Product product;

  const EdicaoProdutoScreen({super.key, required this.product});

  @override
  EdicaoProdutoScreenState createState() => EdicaoProdutoScreenState();
}

class EdicaoProdutoScreenState extends State<EdicaoProdutoScreen> {
  late TextEditingController _nomeProdutoController;
  late TextEditingController _descricaoProdutoController;
  late TextEditingController _precoController;
  late TextEditingController _quantidadeEstoqueController;
  late TextEditingController _categoriaController;
  late TextEditingController _marcaController;
  late TextEditingController _imagemProdutoController;
  late TextEditingController _fichaTecnicaController;
  late bool ativo;

  @override
  void initState() {
    super.initState();
    _nomeProdutoController = TextEditingController(text: widget.product.nomeProduto);
    _descricaoProdutoController = TextEditingController(text: widget.product.descricaoProduto);
    _precoController = TextEditingController(text: widget.product.preco.toString());
    _quantidadeEstoqueController = TextEditingController(text: widget.product.quantidadeEstoque.toString());
    _categoriaController = TextEditingController(text: widget.product.categoria);
    _marcaController = TextEditingController(text: widget.product.marca);
    _imagemProdutoController = TextEditingController(text: widget.product.imagemProduto);
    _fichaTecnicaController = TextEditingController(text: widget.product.fichaTecnica);
    ativo = widget.product.ativo;
  }

  @override
  void dispose() {
    _nomeProdutoController.dispose();
    _descricaoProdutoController.dispose();
    _precoController.dispose();
    _quantidadeEstoqueController.dispose();
    _categoriaController.dispose();
    _marcaController.dispose();
    _imagemProdutoController.dispose();
    _fichaTecnicaController.dispose();
    super.dispose();
  }

  Future<void> _atualizarProduto() async {
    final updatedProduct = widget.product.copyWith(
      nomeProduto: _nomeProdutoController.text,
      descricaoProduto: _descricaoProdutoController.text,
      preco: double.parse(_precoController.text),
      quantidadeEstoque: int.parse(_quantidadeEstoqueController.text),
      categoria: _categoriaController.text,
      marca: _marcaController.text,
      imagemProduto: _imagemProdutoController.text,
      fichaTecnica: _fichaTecnicaController.text,
      ativo: ativo,
    );

     await Provider.of<ProductProvider>(context, listen: false).updateProduct(updatedProduct);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto atualizado com sucesso!')),
      );
      Navigator.pop(context, updatedProduct);
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(_nomeProdutoController, 'Nome do Produto', icon: Icons.label),
                const SizedBox(height: 16),
                _buildTextField(_descricaoProdutoController, 'Descrição', icon: Icons.description),
                const SizedBox(height: 16),
                _buildTextField(_precoController, 'Preço', icon: Icons.attach_money, inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ]),
                const SizedBox(height: 16),
                _buildTextField(_quantidadeEstoqueController, 'Quantidade em Estoque', icon: Icons.storage),
                const SizedBox(height: 16),
                _buildTextField(_categoriaController, 'Categoria', icon: Icons.category),
                const SizedBox(height: 16),
                _buildTextField(_marcaController, 'Marca', icon: Icons.branding_watermark),
                const SizedBox(height: 16),
                _buildTextField(_imagemProdutoController, 'URL da Imagem', icon: Icons.image),
                const SizedBox(height: 16),
                _buildTextField(_fichaTecnicaController, 'Ficha Técnica', icon: Icons.description),
                const SizedBox(height: 24),
                SwitchListTile(
                  title: const Text('Ativo', style: TextStyle(color: Colors.white)),
                  value: ativo,
                  onChanged: (value) {
                    setState(() {
                      ativo = value;
                    });
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.grey,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _atualizarProduto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Atualizar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
      inputFormatters: inputFormatters,
      style: const TextStyle(color: Colors.white),
    );
  }
}