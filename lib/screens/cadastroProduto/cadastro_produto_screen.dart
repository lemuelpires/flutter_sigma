import 'package:flutter/material.dart';
import 'package:flutter_sigma/screens/utils/theme.dart';
import 'package:flutter_sigma/widgets/footer.dart';
import 'package:flutter_sigma/widgets/header.dart';

class CadastroProduto extends StatelessWidget {
  final TextEditingController nomeCompletoController = TextEditingController();
  final TextEditingController nomeAbreviadoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController localImagemController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController fichaTecnicaController = TextEditingController();

  CadastroProduto({super.key});

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
              child: Stack(
                children: [
                  // Imagem de fundo
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.network(
                        'https://via.placeholder.com/600x800', // URL de exemplo para a imagem de fundo
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),
                        // Título
                        Center(
                          child: Text(
                            'Cadastro de Produtos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        // Campos de entrada
                        _buildTextField('Nome Completo', nomeCompletoController),
                        SizedBox(height: 16),
                        _buildTextField('Nome Abreviado', nomeAbreviadoController),
                        SizedBox(height: 16),
                        _buildTextField('Valor', valorController, isNumber: true),
                        SizedBox(height: 16),
                        _buildTextField('Local Imagem', localImagemController),
                        SizedBox(height: 16),
                        _buildTextField('Descrição', descricaoController, maxLines: 3),
                        SizedBox(height: 16),
                        _buildTextField('Ficha Técnica', fichaTecnicaController, maxLines: 3),
                        SizedBox(height: 24),
                        // Botão de cadastro
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Implementar ação de cadastro
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cadastrar',
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
                ],
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
