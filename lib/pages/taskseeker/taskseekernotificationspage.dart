import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskSeekerNotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskSeekerId = FirebaseAuth.instance.currentUser?.uid;

    if (taskSeekerId == null) {
      return Center(child: Text('User not authenticated'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('task_applications')
            .where('taskSeekerId', isEqualTo: taskSeekerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading notifications'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data?.docs ?? [];

          if (notifications.isEmpty) {
            return Center(child: Text('No notifications'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final taskId = notification['taskId'];
              final taskDoerId = notification['taskDoerId'];

              return ListTile(
                title: Text('Task Application'),
                subtitle: Text('Task ID: $taskId'),
                trailing: ElevatedButton(
                  onPressed: () {
                    _viewTaskDoerProfile(context, taskDoerId);
                  },
                  child: Text('View Task Doer Profile'),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _viewTaskDoerProfile(BuildContext context, String taskDoerId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDoerProfilePage(taskDoerId: taskDoerId),
      ),
    );
  }
}

class TaskDoerProfilePage extends StatelessWidget {
  final String taskDoerId;

  const TaskDoerProfilePage({Key? key, required this.taskDoerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Doer Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('task_doers')
            .doc(taskDoerId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading profile'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final profileData = snapshot.data?.data();

          if (profileData == null) {
            return Center(child: Text('Profile not found'));
          }

          final email = profileData['email'] ?? '';
          final name = profileData['name'] ?? '';
          final phoneNumber = profileData['phoneNumber'] ?? '';
          final preferences = profileData['preferences'] ?? '';
          final skills = profileData['skills'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email: $email',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Name: $name',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Phone Number: $phoneNumber',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Preferences: $preferences',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Skills: $skills',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskSeekerNotificationsPage(),
    );
  }
}
