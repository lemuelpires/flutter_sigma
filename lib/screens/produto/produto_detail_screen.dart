import 'package:flutter/material.dart';
import 'package:flutter_sigma/providers/produto_providers.dart';
import 'package:flutter_sigma/models/produto_model.dart';
import 'package:provider/provider.dart';

class ProdutoPage extends StatefulWidget {
  final int productId;

  const ProdutoPage({super.key, required this.productId});

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  final TextEditingController _cepController = TextEditingController();
  String _freteInfo = '';
  bool _isCalculatingFrete = false;

  Future<void> _calcularFrete(String cep) async {
    setState(() {
      _isCalculatingFrete = true;
    });

    try {
      // Simulação de uma chamada à API dos Correios ou serviço de cálculo de frete.
      // Substitua pela lógica real de cálculo de frete, como uma chamada HTTP.
      await Future.delayed(const Duration(seconds: 2)); // Simulação de tempo de resposta
      setState(() {
        _freteInfo = 'Frete calculado: R\$ 25.00 para o CEP $cep';
      });
    } catch (error) {
      setState(() {
        _freteInfo = 'Erro ao calcular frete. Verifique o CEP e tente novamente.';
      });
    } finally {
      setState(() {
        _isCalculatingFrete = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Product?>(
        future: Provider.of<ProductProvider>(context, listen: false).getProductById(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'Produto não encontrado.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final product = snapshot.data!;
          int selectedQuantity = 1;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagem do produto
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(product.imagemProduto),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    product.nomeProduto,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Preço: \$${product.preco.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Text(
                              'Quantidade:',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(width: 10),
                            DropdownButton<int>(
                              dropdownColor: Colors.grey[900],
                              value: selectedQuantity,
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedQuantity = newValue;
                                  });
                                }
                              },
                              items: List.generate(
                                product.quantidadeEstoque,
                                (index) => DropdownMenuItem<int>(
                                  value: index + 1,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Estoque: ${product.quantidadeEstoque}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Campo de cálculo de frete
                  TextField(
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Digite seu CEP',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _isCalculatingFrete
                        ? null
                        : () {
                            if (_cepController.text.isNotEmpty) {
                              _calcularFrete(_cepController.text);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: _isCalculatingFrete
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Calcular Frete'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _freteInfo,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Botões de ação
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Produto comprado com sucesso!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text('Comprar'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Produto adicionado ao carrinho!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                          child: const Text('Adicionar ao Carrinho'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Descrição: ${product.descricaoProduto}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Ficha Técnica:',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.fichaTecnica,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
