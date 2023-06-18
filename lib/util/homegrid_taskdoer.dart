import 'package:flutter/material.dart';
import 'package:taskmatch/util/tasklistscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Discoverers extends StatelessWidget {
  const Discoverers({Key? key, required this.document}) : super(key: key);

  final QueryDocumentSnapshot<Object?> document;

  @override
  Widget build(BuildContext context) {
    final title = document['title'] ?? '';
    final description = document['description'] ?? '';
    final budget = document['budget']?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskListScreen(document: document),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Text(
                  '\$$budget',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
