import 'package:flutter/material.dart';
class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: const Center(
        child: Text(
          'This is the change password screen.',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}