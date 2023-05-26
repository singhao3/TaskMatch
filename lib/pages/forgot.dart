import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  bool _isSending = false;

  Future<void> _sendPasswordResetEmail() async {
    try {
      setState(() {
        _isSending = true;
        _errorMessage = null;
      });
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      setState(() {
        _isSending = false;
        _errorMessage = null;
      });
      _showSuccessDialog();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSending = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _isSending = false;
        _errorMessage = 'An unexpected error occurred, please try again later.';
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('A password reset email has been sent to ${_emailController.text}.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email.';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isSending
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _sendPasswordResetEmail();
                        }
                      },
                child: _isSending
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Text('Send Password Reset Email'),
              ),
              SizedBox(height: 8.0),
              Text(
                _errorMessage ?? '',
                style: TextStyle(
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}