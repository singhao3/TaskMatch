import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmatch/auth.dart';
import 'package:taskmatch/pages/taskseeker/taskseeker_homepage.dart';
import 'package:taskmatch/pages/taskdoer/taskdoer_homepage.dart';
import 'package:taskmatch/pages/login_screen.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          final user = snapshot.data;
          if (user != null) {
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('task_doers')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  // User is a task-doer, navigate to task-doer home page
                  return const TaskDoerHome();
                } else {
                  // User is not a task-doer, navigate to task-seeker home page
                  return const TaskSeekerHome();
                }
              },
            );
          } else {
            return const LoginScreen();
          }
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
