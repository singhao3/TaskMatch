import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmatch/util/tasklistscreen.dart';

class DiscoverGrid extends StatefulWidget {
  final List<QueryDocumentSnapshot> documents;

  const DiscoverGrid({Key? key, required this.documents}) : super(key: key);

  @override
  _DiscoverGridState createState() => _DiscoverGridState();
}

class _DiscoverGridState extends State<DiscoverGrid> {
  List<bool> favorites = [];

  @override
  void initState() {
    super.initState();
    favorites = List<bool>.filled(widget.documents.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.documents.length,
      itemBuilder: (context, index) {
        final document = widget.documents[index];
        final title = document['title'] ?? '';
        final description = document['description'] ?? '';
        final budget = document['budget'] ?? '';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskListScreen(document: document),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
      },
    );
  }
}
