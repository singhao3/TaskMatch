import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'update_task_page.dart';

class MyTasksPage extends StatefulWidget {
  const MyTasksPage({Key? key}) : super(key: key); 

  @override
  _MyTasksPageState createState() => _MyTasksPageState();
}

class _MyTasksPageState extends State<MyTasksPage> {
  late User _currentUser;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _tasksStream;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _tasksStream = FirebaseFirestore.instance
        .collection('tasks')
        .where('userId', isEqualTo: _currentUser.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'), 
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _tasksStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!.docs;

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final taskId = task.id;
                final title = task['title'];
                final description = task['description'];

                return ListTile(
                  title: Text(title),
                  subtitle: Text(description),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit), 
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateTaskPage(taskId: taskId),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator()); 
          }
        },
      ),
    );
  }
}
