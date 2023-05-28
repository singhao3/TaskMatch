import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole {
  TaskDoer,
  TaskSeeker,
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _preferencesController = TextEditingController();
  UserRole _selectedRole = UserRole.TaskDoer;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _skillsController.dispose();
    _preferencesController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Store additional user information in Firestore or user profile
      final user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(_nameController.text.trim());

        // Store role-specific information
        if (_selectedRole == UserRole.TaskDoer) {
          await _storeTaskDoerInfo(user.uid, user.email!);
        } else {
          await _storeTaskSeekerInfo(user.uid, user.email!);
        }

        // Navigate to the appropriate home screen based on role
        navigateToHomeScreen(user.uid);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Handle any signup errors here
      });
    }
  }

  Future<void> _storeTaskDoerInfo(String userId, String email) async {
    try {
      // Retrieve the values entered by the user
      String name = _nameController.text.trim();
      String phoneNumber = _phoneController.text.trim();
      String skills = _skillsController.text.trim();
      String preferences = _preferencesController.text.trim();

      // Store the task-doer specific information in Firestore or a separate collection
      // Example: Create a 'task_doers' collection and store the user information under the user's document
      await FirebaseFirestore.instance
          .collection('task_doers')
          .doc(userId)
          .set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'skills': skills,
        'preferences': preferences,
      });
    } catch (e) {
      // Handle any errors that occur during storing the task-doer information
      print('Error storing task-doer information: $e');
    }
  }

  Future<void> _storeTaskSeekerInfo(String userId, String email) async {
    try {
      // Retrieve the values entered by the user
      String name = _nameController.text.trim();
      String phoneNumber = _phoneController.text.trim();

      // Store the task-seeker specific information in Firestore or a separate collection
      // Example: Create a 'task_seekers' collection and store the user information under the user's document
      await FirebaseFirestore.instance
          .collection('task_seekers')
          .doc(userId)
          .set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      // Handle any errors that occur during storing the task-seeker information
      print('Error storing task-seeker information: $e');
    }
  }

  void navigateToHomeScreen(String userId) {
    // Based on the selected role, navigate the user to the respective home screen
    if (_selectedRole == UserRole.TaskDoer) {
      // Navigate to the TaskDoerHomePage
      Navigator.pushReplacementNamed(context, '/taskdoerhome');
    } else {
      // Navigate to the TaskSeekerHomePage
      Navigator.pushReplacementNamed(context, '/taskseekerhome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            if (_selectedRole == UserRole.TaskDoer) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _skillsController,
                decoration: InputDecoration(
                  labelText: 'Skills',
                  prefixIcon: Icon(Icons.work),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _preferencesController,
                decoration: InputDecoration(
                  labelText: 'Preferences',
                  prefixIcon: Icon(Icons.settings),
                ),
              ),
            ],
            const SizedBox(height: 16),
            DropdownButton<UserRole>(
              value: _selectedRole,
              onChanged: (UserRole? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: const [
                DropdownMenuItem<UserRole>(
                  value: UserRole.TaskDoer,
                  child: Text('Task Doer'),
                ),
                DropdownMenuItem<UserRole>(
                  value: UserRole.TaskSeeker,
                  child: Text('Task Seeker'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: signUp,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
