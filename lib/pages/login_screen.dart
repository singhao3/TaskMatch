import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import 'forgot.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  Widget buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: const <Widget>[
          Text(
            'Welcome to TaskMatch!',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          Text(
            'Connecting you with the right tasks at the right time.',
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildEntryField(String title, TextEditingController controller) {
    return Container(
      width: 300,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      width: 400,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildErrorMessage() {
    return Text(errorMessage == '' ? '' : 'Hmmm ? $errorMessage');
  }

  Widget buildLoginButton() {
    return Container(
      width: 200,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Log in' : 'Sign Up'),
      ),
    );
  }
  Widget buildForgotPasswordButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: TextButton(
      onPressed: () {
        // Navigate to the forgot password page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
        );
      },
      child: Text('Forgot password?'),
    ),
  );
}

  Widget buildSignUporLoginButton(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin
            ? 'Don\'t have an account? Sign up'
            : 'Already have an account? Login'),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildWelcomeText(),
          buildEntryField('Email', _controllerEmail),
          buildEntryField('Password', _controllerPassword),
          buildErrorMessage(),
          buildLoginButton(),
          buildSignUporLoginButton(context),
          buildForgotPasswordButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('TaskMatch'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: buildBody(context),
        ),
      ),
    );
  }
}
