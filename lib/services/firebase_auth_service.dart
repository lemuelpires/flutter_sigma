import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:flutter_sigma/models/usuario_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  Future<User?> registerUser(Usuario novoUsuario, String senha) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: novoUsuario.email,
        password: senha,
      );

      // Adiciona o usuário ao Firestore
      await _firestore.collection('usuarios').doc(userCredential.user!.uid).set(novoUsuario.toJson());

      _logger.i('Usuário registrado com sucesso: ${userCredential.user?.email}');
      return userCredential.user;
    } catch (e) {
      _logger.e('Erro ao registrar usuário: $e');
      rethrow;
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
      rethrow;  // Propaga o erro para que a interface trate
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

