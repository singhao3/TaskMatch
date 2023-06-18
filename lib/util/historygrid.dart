import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final taskSeekerId = user?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Task History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('taskSeekerId', isEqualTo: taskSeekerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final tasks = snapshot.data?.docs ?? [];

          if (tasks.isEmpty) {
            return Center(
              child: Text('No tasks posted.'),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final title = task['title'] ?? '';
              final description = task['description'] ?? '';
              final status = task['status'] ?? 'Not Applied';

              return ListTile(
                title: Text(title),
                subtitle: Text(description),
                trailing: Text(status),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TaskDetailsScreen(taskId: task.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;

  TaskDetailsScreen({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(taskId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final task = snapshot.data?.data() as Map<String, dynamic>?;

          if (task == null) {
            return Center(
              child: Text('Task not found.'),
            );
          }

          final title = task['title'] ?? '';
          final description = task['description'] ?? '';
          final budget = task['budget'] ?? '';
          final image = task['image'] ?? '';

          return Column(
            children: [
              if (image.isNotEmpty) Image.network(image),
              SizedBox(height: 16.0),
              ListTile(
                title: Text('Title'),
                subtitle: Text(title),
              ),
              ListTile(
                title: Text('Description'),
                subtitle: Text(description),
              ),
              ListTile(
                title: Text('Budget'),
                subtitle: Text(budget.toString()),
              ),
            ],
          );
        },
      ),
    );
  }
}
