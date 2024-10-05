import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();  // Instância do logger

  // Função para adicionar um novo documento a uma coleção
  Future<void> adicionarDocumento(String collectionPath, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).add(data);
      _logger.i("Documento adicionado com sucesso!");  // Substitua print por logger
    } catch (e) {
      _logger.e("Erro ao adicionar documento: $e");
    }
  }

  // Função para buscar um documento específico por ID
  Future<DocumentSnapshot> buscarDocumentoPorId(String collectionPath, String documentId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(collectionPath).doc(documentId).get();
      _logger.i("Documento buscado com sucesso!");  // Log informativo
      return doc;
    } catch (e) {
      _logger.e("Erro ao buscar documento: $e");
      rethrow;
    }
  }

  // Função para atualizar um documento existente
  Future<void> atualizarDocumento(String collectionPath, String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
      _logger.i("Documento atualizado com sucesso!");  // Substitua print por logger
    } catch (e) {
      _logger.e("Erro ao atualizar documento: $e");
    }
  }

  // Função para deletar um documento
  Future<void> deletarDocumento(String collectionPath, String documentId) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
      _logger.i("Documento deletado com sucesso!");  // Substitua print por logger
    } catch (e) {
      _logger.e("Erro ao deletar documento: $e");
    }
  }

  // Função para buscar todos os documentos de uma coleção
  Future<List<QueryDocumentSnapshot>> buscarTodosDocumentos(String collectionPath) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collectionPath).get();
      _logger.i("Documentos buscados com sucesso!");  // Substitua print por logger
      return querySnapshot.docs;
    } catch (e) {
      _logger.e("Erro ao buscar documentos: $e");
      rethrow;
    }
  }
}
