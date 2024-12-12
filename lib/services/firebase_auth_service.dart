import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:flutter_sigma/models/usuario_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  // Getter para o usuário atual
  User? get currentUser => _auth.currentUser;

  Future<User?> registerUser(Usuario novoUsuario, String senha) async {
    try {
      // Log para saber quando o método de registro é chamado
      _logger.i('Iniciando o registro do usuário: ${novoUsuario.email}');

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: novoUsuario.email,
        password: senha,
      );

      // Log após o registro
      _logger
          .i('Usuário registrado com sucesso: ${userCredential.user?.email}');

      // Salvar o usuário no Firestore
      await _firestore
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set(novoUsuario.toJson());

      return userCredential.user;
    } catch (e) {
      // Log para capturar o erro
      _logger.e('Erro ao registrar o usuário: $e');
      rethrow; // Reenvia o erro para ser tratado no nível superior
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      _logger.i('Login bem-sucedido: ${userCredential.user?.email}');
      return userCredential.user;
    } catch (e) {
      _logger.e('Erro ao fazer login: $e');
      rethrow; // Propaga o erro para que a interface trate
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _logger.i('Logout bem-sucedido');
    } catch (e) {
      _logger.e('Erro ao fazer logout: $e');
    }
  }
}
