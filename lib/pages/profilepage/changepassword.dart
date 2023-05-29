import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        final User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final String oldPassword = _oldPasswordController.text.trim();
          final String newPassword = _newPasswordController.text.trim();

          // Re-authenticate the user with their old password
          final credential = EmailAuthProvider.credential(email: user.email!, password: oldPassword);
          await user.reauthenticateWithCredential(credential);

          // Change the user's password
          await user.updatePassword(newPassword);

          // Show a success message to the user
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Password changed successfully.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context); // Navigate back to the previous screen
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to change password. ${e.message}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _changePassword,
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
