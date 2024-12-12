import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Termos e Condições',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Bem-vindo ao nosso aplicativo! Ao utilizar nossos serviços, você concorda com os seguintes termos de uso. Leia-os atentamente.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('1. Aceitação dos Termos'),
              _buildParagraph(
                  'Ao acessar ou utilizar nosso aplicativo, você concorda em cumprir estes Termos de Uso e todas as leis e regulamentos aplicáveis. Se você não concordar com qualquer um destes termos, está proibido de usar ou acessar este aplicativo.'),
              const SizedBox(height: 24),
              _buildSectionTitle('2. Uso do Aplicativo'),
              _buildParagraph(
                  'Você concorda em utilizar nosso aplicativo apenas para fins legais e de acordo com os Termos de Uso. É proibido usar o aplicativo de forma que possa causar danos, desativar, sobrecarregar ou comprometer o funcionamento do aplicativo.'),
              const SizedBox(height: 24),
              _buildSectionTitle('3. Modificações nos Termos'),
              _buildParagraph(
                  'Reservamo-nos o direito de revisar e atualizar estes Termos de Uso a qualquer momento. É sua responsabilidade revisar os Termos regularmente. O uso contínuo do aplicativo após alterações constitui aceitação das mudanças.'),
              const SizedBox(height: 24),
              _buildSectionTitle('4. Propriedade Intelectual'),
              _buildParagraph(
                  'Todo o conteúdo apresentado no aplicativo, incluindo textos, gráficos, logotipos, ícones, imagens, clipes de áudio, downloads digitais e compilações de dados, é propriedade exclusiva da nossa empresa ou de nossos fornecedores de conteúdo.'),
              const SizedBox(height: 24),
              _buildSectionTitle('5. Limitação de Responsabilidade'),
              _buildParagraph(
                  'Em nenhuma circunstância seremos responsáveis por quaisquer danos diretos, indiretos, incidentais, especiais ou consequentes que resultem do uso ou da incapacidade de usar o aplicativo.'),
              const SizedBox(height: 24),
              _buildSectionTitle('6. Rescisão'),
              _buildParagraph(
                  'Podemos encerrar ou suspender seu acesso ao aplicativo imediatamente, sem aviso prévio ou responsabilidade, se você violar os Termos de Uso.'),
              const SizedBox(height: 24),
              _buildSectionTitle('7. Contato'),
              _buildParagraph(
                  'Se você tiver alguma dúvida sobre estes Termos de Uso, entre em contato conosco por meio de nossos canais de atendimento.'),
              const SizedBox(height: 24),
              const Text(
                'Última atualização: Dezembro de 2024',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}