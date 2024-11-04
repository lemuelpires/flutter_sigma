import 'package:flutter/material.dart';
import 'package:flutter_sigma/screens/utils/theme.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';

class CadastroAnuncio extends StatelessWidget {
  final TextEditingController idProdutoController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController referenciaImagemController = TextEditingController();

  CadastroAnuncio({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildTheme(), // Aplica o tema customizado
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            CustomHeader(title: '',), // Exibe o CustomHeader no topo
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    // Título da página
                    Center(
                      child: Text(
                        'Cadastro de Anúncio',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Campos de entrada
                    _buildTextField('ID do Produto', idProdutoController, isNumber: true),
                    SizedBox(height: 16),
                    _buildTextField('Título', tituloController),
                    SizedBox(height: 16),
                    _buildTextField('Descrição', descricaoController, maxLines: 3),
                    SizedBox(height: 16),
                    _buildTextField('Preço', precoController, isNumber: true),
                    SizedBox(height: 16),
                    _buildTextField('Referência da Imagem', referenciaImagemController),
                    SizedBox(height: 24),
                    // Botão de cadastro
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para cadastrar o anúncio
                          // Exemplo de criação do objeto com `ativo` como true:
                          final novoAnuncio = {
                            "idProduto": int.tryParse(idProdutoController.text) ?? 0,
                            "titulo": tituloController.text,
                            "descricao": descricaoController.text,
                            "preco": double.tryParse(precoController.text) ?? 0.0,
                            "referenciaImagem": referenciaImagemController.text,
                            "data": DateTime.now().toIso8601String(),
                            "ativo": true,
                          };
                          // Ação de cadastro a ser implementada
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cadastrar Anúncio',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Footer(), // Exibe o Footer na parte inferior
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para criar os campos de entrada
  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
