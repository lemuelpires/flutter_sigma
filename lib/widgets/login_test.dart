/*import 'package:flutter/material.dart';

class TesteLogin extends StatefulWidget {
  const TesteLogin({super.key});

  @override
  State<TesteLogin> createState() => _TesteLoginState();
}

class _TesteLoginState extends State<TesteLogin> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF182428),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.all(22),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFFEEF4F8),
                      fontSize: 30,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      'Usuário',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFFEEF4F8),
                        fontSize: 20,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: 348,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A3A3F),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      'Senha',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFFEEF4F8),
                        fontSize: 20,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: 348,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A3A3F),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009688),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      textStyle: const TextStyle(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Button'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
