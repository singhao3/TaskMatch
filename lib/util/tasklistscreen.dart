import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskListScreen extends StatelessWidget {
  final QueryDocumentSnapshot document;

  const TaskListScreen({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = document['title'] ?? '';
    final description = document['description'] ?? '';
    final budget = document['budget'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Budget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$$budget',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _showApplyConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'Apply Now',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showApplyConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Apply for Task'),
          content: Text('Are you sure you want to apply for this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _applyForTask();
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _applyForTask() {
    // Retrieve the current user's ID
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final taskDoerId = user.uid; // Use the user's ID as the task doer's ID
      final taskId = document.id; // Assuming the document ID is the task ID

      FirebaseFirestore.instance
          .collection('tasks')
          .doc(taskId)
          .update({'applicants': FieldValue.arrayUnion([taskDoerId])});
    }
  }
}
