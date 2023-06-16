import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              						onPressed: () {},
              						style: ElevatedButton.styleFrom(
                						backgroundColor: Colors.white,
              						),
              						child: Text(
                						'Chat Now',
                						style: TextStyle(
                  						color: Colors.black,
                						),
              						),
            					),
									SizedBox(width: 8),
									ElevatedButton(
              						onPressed: () {},
              						style: ElevatedButton.styleFrom(
                						backgroundColor: Colors.white,
              						),
              						child: Text(
                						'Apply Now',
                						style: TextStyle(
                  						color: Colors.black,
                						),
              						),
            					),
          ],
        ),
      ),
    );
  }
}
