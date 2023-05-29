import 'package:flutter/material.dart';
import 'package:taskmatch/pages/profilepage/customform.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  void handleProfileUpdate(BuildContext context) {
    // Handle profile update submission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyCustomForm(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => handleProfileUpdate(context),
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

