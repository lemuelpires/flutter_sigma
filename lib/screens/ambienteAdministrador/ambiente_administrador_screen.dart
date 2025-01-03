import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AmbienteAdministrador extends StatefulWidget {
  const AmbienteAdministrador({super.key});

  @override
  State<AmbienteAdministrador> createState() => _AmbienteAdministradorState();
}

class _AmbienteAdministradorState extends State<AmbienteAdministrador> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userEmail;

  @override
  void initState() {
    super.initState();

    // Verificar se já há um usuário logado quando o app é iniciado
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      setState(() {
        _userEmail = currentUser.email; // Atribui o email do usuário
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Ambiente Administrador',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black.withAlpha((0.7 * 255).toInt()),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _userEmail != null
                            ? 'Olá $_userEmail,\n seja Bem Vindo!'
                            : 'Carregando...',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: const [
                          MenuButton(
                            icon: Icons.inventory,
                            label: 'Produtos',
                            color: Color(0xFF7FFF00),
                            routeName: '/lista_produtos',
                          ),
                          MenuButton(
                            icon: Icons.article,
                            label: 'Anúncios',
                            color: Color(0xFFFFA500),
                            routeName: '/lista_anuncios',
                          ),
                          MenuButton(
                            icon: Icons.group,
                            label: 'Usuários',
                            color: Color(0xFFFF1493),
                            routeName: '/lista_usuarios',
                          ),
                          MenuButton(
                            icon: Icons.videogame_asset,
                            label: 'Jogos',
                            color: Color(0xFF87CEFA),
                            routeName: '/lista_jogos',
                          ),
                          MenuButton(
                            icon: Icons.image,
                            label: 'Imagens',
                            color: Color(0xFF32CD32),
                            routeName: '/em_construcao',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String routeName;

  const MenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: color.withAlpha((0.3 * 255).toInt()),
      highlightColor: color.withAlpha((0.1 * 255).toInt()),
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 81, 81, 81),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha((0.4 * 255).toInt()),
              blurRadius: 10,
              offset: const Offset(3, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 80),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}