import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithEmailAndPassword(
    String email, String password
  ) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      // merge user data
      _firestore.collection('users').doc(credential.user!.uid).set(
        {
          'uid': credential.user!.uid,
          'email': email,
        },
        SetOptions(
          merge: true
        )
      );

      return credential;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<UserCredential?> createUserWithEmailAndPassword(
    String email, String password
  ) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      // create collection users using add
      _firestore.collection('users').add(
        {
          'uid': credential.user!.uid,
          'email': email,
        }
      );
      return credential;
    } on FirebaseAuthException {
      return null;
    }
  }

  // forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

}