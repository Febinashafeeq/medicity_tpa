import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> signInAdmin({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = cred.user!.uid;

      final adminDoc =
      await _firestore.collection('admin').doc(uid).get();

      if (!adminDoc.exists) {
        await _auth.signOut();
        throw Exception('You are not authorized as admin');
      }

      final data = adminDoc.data()!;

      if (data['isActive'] != true) {
        await _auth.signOut();
        throw Exception('Admin account disabled');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('adminName', data['name']);
      await prefs.setString('adminEmail', data['e_mail']);
    }

    // 🔥 Firebase specific errors
    on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No account found for this email');
        case 'wrong-password':
          throw Exception('Incorrect password');
        case 'invalid-email':
          throw Exception('Invalid email address');
        case 'user-disabled':
          throw Exception('This account is disabled');
        default:
          throw Exception('Login failed. Try again');
      }
    }
  }
}