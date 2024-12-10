





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





/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mood_tracker_screen.dart'; // Ensure this is correctly imported

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
*/


/**
 * import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mood_tracker_screen.dart'; // Import the MoodTrackerScreen

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoginMode = true; // Track if the current mode is login or signup
  String _message = ''; // For success/error messages

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
        setState(() {
          _message = 'Login successful!';
        });
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MoodTrackerScreen()),
        );
      }
    } catch (e) {
      // Handle specific error cases
      String errorMessage;
      if (e is FirebaseAuthException) {
        if (_isLoginMode) {
          if (e.code == 'user-not-found' || e.code == 'wrong-password') {
            errorMessage = 'Incorrect email or password. Please try again.';
          } else {
            errorMessage = 'Error: ${e.message}';
          }
        } else {
          if (e.code == 'email-already-in-use') {
            errorMessage = 'Email already taken. Please choose another one.';
          } else {
            errorMessage = 'Error: ${e.message}';
          }
        }
      } else {
        errorMessage = 'An unknown error occurred.';
      }
      setState(() {
        _message = errorMessage;
      });
    }
  }

  void _toggleAuthMode() {
    setState(() {
      _isLoginMode = !_isLoginMode; // Toggle the mode
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
          child: SingleChildScrollView( // Ensures the UI doesn't overflow on small screens
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Full-width button
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isLoginMode ? 'Login' : 'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 16),
                // Toggle the mode for switching between login/signup
                TextButton(
                  onPressed: _toggleAuthMode,
                  child: Text(
                    _isLoginMode
                        ? 'Create an account'
                        : 'Already have an account? Login',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Display error or success messages
                if (_message.isNotEmpty)
                  Text(
                    _message,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 */