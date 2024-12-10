import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/authentication.dart'; // This is correct as long as AuthenticationScreen is defined here

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collaborative Mood Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthenticationScreen(), // Correct widget name
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure you import the firebase_options.dart file
import 'src/authentication.dart'; // Make sure this path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collaborative Mood Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Authentication(),
    );
  }
}
*/