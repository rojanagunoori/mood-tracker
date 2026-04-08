
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mood_tracker_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = ''; // For success/error messages
  bool _isLoginMode = true; // Track if the current mode is login or signup

  Future<void> _authenticate() async {
    setState(() {
      _message = ''; // Reset the message before each authentication attempt
    });
    try {
      if (_isLoginMode) {
        // Login logic
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MoodTrackerScreen()),
        );
      } else {
        // Signup logic
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        setState(() {
          _message = 'Sign up successful! You can now log in.';
        });
      }
    } catch (e) {
      setState(() {
        _message = e.toString();
      });
    }
  }

  void _toggleAuthMode() {
    setState(() {
      _isLoginMode = !_isLoginMode; // Toggle between login and sign-up
      _message = ''; // Clear message when switching modes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Sign Up'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _authenticate,
                  child: Text(_isLoginMode ? 'Login' : 'Sign Up'),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: _toggleAuthMode,
                  child: Text(
                    _isLoginMode
                        ? 'Create an account'
                        : 'Already have an account? Login',
                  ),
                ),
                if (_message.isNotEmpty)
                  Text(
                    _message,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



