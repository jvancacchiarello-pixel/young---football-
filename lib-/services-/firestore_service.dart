import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get uid => _auth.currentUser!.uid;

  // Crea il profilo del giocatore
  Future<void> creaProfilo({
    required String nome,
    required String cognome,
  }) async {
    await _db.collection('utenti').doc(uid).set({
      'nome': nome.trim(),
      'cognome': cognome.trim(),
      'uid': uid,
      'email': _auth.currentUser?.email,
      'creatoIl': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Crea una nuova squadra
  Future<String> creaTeam(String nomeTeam) async {
    final doc = await _db.collection('teams').add({
      'nome': nomeTeam.trim(),
      'creatoreId': uid,
      'membri': [uid],
      'creatoIl': FieldValue.serverTimestamp(),
    });

    return doc.id;
  }

  // Mostra le squadre dell'utente
  Stream<QuerySnapshot<Map<String, dynamic>>> mieiTeam() {
    return _db
        .collection('teams')
        .where('membri', arrayContains: uid)
        .snapshots();
  }

  // Entra in una squadra
  Future<void> entraNelTeam(String teamId) async {
    await _db.collection('teams').doc(teamId).update({
      'membri': FieldValue.arrayUnion([uid]),
    });
  }

  // Invia un messaggio nella chat della squadra
  Future<void> inviaMessaggio({
    required String teamId,
    required String testo,
  }) async {
    if (testo.trim().isEmpty) return;

    await _db
        .collection('teams')
        .doc(teamId)
        .collection('messaggi')
        .add({
      'testo': testo.trim(),
      'autoreId': uid,
      'autoreEmail': _auth.currentUser?.email,
      'inviatoIl': FieldValue.serverTimestamp(),
    });
  }

  // Legge i messaggi della squadra
  Stream<QuerySnapshot<Map<String, dynamic>>> messaggi(String teamId) {
    return _db
        .collection('teams')
        .doc(teamId)
        .collection('messaggi')
        .orderBy('inviatoIl', descending: false)
        .snapshots();
  }
}
