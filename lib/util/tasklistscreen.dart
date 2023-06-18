import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskListScreen extends StatefulWidget {
  final QueryDocumentSnapshot document;

  const TaskListScreen({Key? key, required this.document}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  bool _isApplied = false;
  bool _isInWishlist = false;

  @override
  void initState() {
    super.initState();
    _retrieveWishlistStatus();
  }

  void _retrieveWishlistStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final taskId = widget.document.id;

      final wishlistRef = FirebaseFirestore.instance
          .collection('task_doers')
          .doc(user.uid)
          .collection('wishlist')
          .doc(taskId);

      wishlistRef.get().then((snapshot) {
        if (snapshot.exists) {
          setState(() {
            _isInWishlist = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.document['title'] ?? '';
    final description = widget.document['description'] ?? '';
    final budget = widget.document['budget'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Budget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$$budget',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (_isApplied)
                  const Text(
                    'Applied',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      _showApplyConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Apply Now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    _toggleWishlist();
                  },
                  child: Icon(
                    _isInWishlist ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
              ],
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
          title: const Text('Apply for Task'),
          content: const Text('Are you sure you want to apply for this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _applyForTask();
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _applyForTask() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final taskDoerId = user.uid;
      final taskId = widget.document.id;

      FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
        'applicants': FieldValue.arrayUnion([taskDoerId]),
        'status': 'Applied',
      }).then((_) {
        setState(() {
          _isApplied = true;
        });
      });
    }
  }

  void _toggleWishlist() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final taskId = widget.document.id;

      final wishlistRef = FirebaseFirestore.instance
          .collection('task_doers')
          .doc(user.uid)
          .collection('wishlist')
          .doc(taskId);

      if (_isInWishlist) {
        wishlistRef.delete().then((_) {
          setState(() {
            _isInWishlist = false;
          });
        });
      } else {
        wishlistRef.set({}).then((_) {
          setState(() {
            _isInWishlist = true;
          });
        });
      }
    }
  }
}
