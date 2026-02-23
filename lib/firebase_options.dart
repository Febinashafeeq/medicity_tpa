import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => web;

  static const FirebaseOptions web = FirebaseOptions(
    apiKey:            'AIzaSyDoNC3duo_gBxR84UzI8Fp6ID_tgjVYql8',
    appId:             '1:814866520609:web:952f98eb0463f39d306160',
    messagingSenderId: '814866520609',
    projectId:         'medicity-66acd',
    authDomain:        'medicity-66acd.firebaseapp.com',
    storageBucket:     'medicity-66acd.firebasestorage.app',
    measurementId:     'G-TV8NW6N76S',
  );
}