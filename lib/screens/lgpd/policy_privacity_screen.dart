import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                'Política de Privacidade',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Nesta Política de Privacidade, explicamos aos nossos visitantes e usuários as formas e meios que protegemos e tratamos os dados coletados em nossa plataforma.'
                '\n\nNós levamos extremamente a sério a proteção dos dados pessoais coletados e armazenados. Neste documento, detalhamos como e por que fazemos esta coleta, e como você pode solicitar a retirada, alteração ou exclusão dos seus dados.'
                '\n\nEm caso de dúvidas, entre em contato diretamente com nossa equipe pela aba de contato.'
                '\n\nEste documento foi criado pela Advogada Livia Martins Fioraneli (OAB/SP xxx.xxx) e adaptado para uso neste website.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('1. Sobre a origem dos seus dados pessoais'),
              const Text(
                'Nosso site pode coletar alguns dados pessoais para diferentes objetivos, utilizando tecnologias como:'
                '\n- Website: Formulários, comentários, dúvidas, ou cadastro na plataforma.'
                '\n- Mensagens e comunicações: Dados coletados por WhatsApp, SMS, e-mail, entre outros.'
                '\n- Offline: Dados obtidos em eventos ou organizações.'
                '\n- Dados de terceiros: Informados por redes sociais, governo ou intermediadores de pagamento.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('2. Como e por que coletamos seus dados'),
              const Text(
                'Coletamos dados pessoais para oferecer o melhor serviço possível. Exemplos:'
                '\n- Marketing: Nome, e-mail e telefone para envio de promoções.'
                '\n- Navegação no site: Endereço IP, navegador, páginas acessadas, etc.'
                '\n- Contato: Nome, e-mail, telefone e mensagem enviada.'
                '\n- Uso dos serviços: Pesquisas realizadas, páginas visitadas, compras efetuadas.'
                '\n- Localização: Dados precisos para fornecer serviços solicitados.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('3. Sobre o uso de cookies'),
              const Text(
                'Usamos cookies para melhorar sua experiência de navegação. Você pode bloqueá-los ou limpar o cache a qualquer momento. Cookies são usados para:'
                '\n- Reconhecer seu navegador e fornecer a melhor experiência.'
                '\n- Entender quais seções do site são mais interessantes para você.'
                '\nUtilizamos cookies necessários para oferecer serviços de acordo com a LGPD. Você pode desativá-los no navegador.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('4. Com quem compartilhamos os seus dados pessoais'),
              const Text(
                'Compartilhamos seus dados com:'
                '\n- Prestadores de serviços: Marketing, análise de dados, pagamentos, envio de e-mails.'
                '\n- Anunciantes e parceiros comerciais: Conforme suas instruções.'
                '\n- Comunidades online: Dados visíveis para outros membros.'
                '\n- Investidores e filiais: Conforme instruções.'
                '\n- Autoridades governamentais: Quando exigido por lei.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('5. Seus direitos em relação aos dados coletados'),
              const Text(
                'Você tem o direito de acessar, corrigir, excluir, limitar o tratamento e opor-se ao uso de seus dados pessoais. Para exercer seus direitos, entre em contato conosco.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('6. Sobre a segurança no tratamento dos seus dados'),
              const Text(
                'Garantimos a segurança dos seus dados com medidas como:'
                '\n- Criptografia SSL, firewalls e monitoramento constante.'
                '\n- Servidores seguros protegidos contra acessos não autorizados.'
                '\n- Equipe especializada em atualização de medidas de proteção.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('7. Pedido de modificação, remoção ou alteração'),
              const Text(
                'Você pode solicitar modificações, remoções ou alterações nos seus dados. Entre em contato conosco para atender sua solicitação, respeitando obrigações legais ou contratuais.',
                style: TextStyle(color: Colors.white70),
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
}