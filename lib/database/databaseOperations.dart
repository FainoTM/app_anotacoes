import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations{
  final db = FirebaseFirestore.instance;

  Future<void> createNovaAnotacao(String titulo, String corpo) async {
    final anotacao = <String,dynamic>{
      "titulo": titulo,
      "corpo": corpo,
    };
    await db.collection("anotacoes").add(anotacao).then((documentSnapshot) => print("Nota Adicionada"));
  }

  Future<List<Map<String, dynamic>>> getAnotacao() async {
    QuerySnapshot snapshot = await db.collection('anotacoes').get();
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'titulo': doc['titulo'],
        'corpo': doc['corpo'],
      };
    }).toList();
  }

  Future<void> excludeAnotacao(String id) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection("anotacoes").get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = querySnapshot.docs.first;
      await db.collection("anotacoes").doc(documentSnapshot.id).delete();

    } else{
    }

  }

}