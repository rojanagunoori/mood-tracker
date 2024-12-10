import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyCHfV6KPXjBfCYHs4ZdeFr9nwEPUM1q4yE",
      appId: "1:379733482080:web:278e2695d37fc34c95c105",
      messagingSenderId: "379733482080",
      projectId: "collaborativemoodtracker",
      authDomain: "collaborativemoodtracker.firebaseapp.com",
      storageBucket: "collaborativemoodtracker.firebasestorage.app",
      measurementId: "G-S6D3K6ZRL6",
    );
  }
}
