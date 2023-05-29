import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskWatchlist extends StatefulWidget {
  const TaskWatchlist({Key? key}) : super(key: key);

  @override
  _TaskWatchlistState createState() => _TaskWatchlistState();
}

class _TaskWatchlistState extends State<TaskWatchlist> {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference taskWatchlistRef =
      FirebaseFirestore.instance.collection('task_watchlist');

  List<String> watchlistTasks = [];

  @override
  void initState() {
    super.initState();
    // Fetch the watchlist tasks for the current user
    fetchWatchlistTasks();
  }

  Future<void> fetchWatchlistTasks() async {
    final uid = user?.uid;
    if (uid != null) {
      final snapshot =
          await taskWatchlistRef.doc(uid).get();
      final data = snapshot.data();
      if (data != null) {
        setState(() {
          //watchlistTasks = List<String>.from(data['tasks'] ?? []);
        });
      }
    }
  }

  Future<void> addToWatchlist(String taskId) async {
    final uid = user?.uid;
    if (uid != null) {
      watchlistTasks.add(taskId);
      await taskWatchlistRef.doc(uid).set({'tasks': watchlistTasks});
      setState(() {});
    }
  }

  Future<void> removeFromWatchlist(String taskId) async {
    final uid = user?.uid;
    if (uid != null) {
      watchlistTasks.remove(taskId);
      await taskWatchlistRef.doc(uid).set({'tasks': watchlistTasks});
      setState(() {});
    }
  }

  bool isTaskInWatchlist(String taskId) {
    return watchlistTasks.contains(taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Watchlist'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final taskDocs = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: taskDocs.length,
            itemBuilder: (context, index) {
              final taskDoc = taskDocs[index];
              final taskId = taskDoc.id;
              final taskTitle = taskDoc['title'];

              return ListTile(
                title: Text(taskTitle),
                trailing: IconButton(
                  icon: Icon(
                    isTaskInWatchlist(taskId)
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  onPressed: () {
                    if (isTaskInWatchlist(taskId)) {
                      removeFromWatchlist(taskId);
                    } else {
                      addToWatchlist(taskId);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
