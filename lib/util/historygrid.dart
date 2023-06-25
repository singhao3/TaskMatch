import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmatch/pages/rating_page.dart';
import 'package:taskmatch/util/payment_page.dart';


class HistoryGrid extends StatelessWidget {
  const HistoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('task_seekers')
            .doc(userId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final isTaskSeeker = snapshot.hasData && snapshot.data!.exists;
          return StreamBuilder<QuerySnapshot>(
            stream: isTaskSeeker
                ? FirebaseFirestore.instance
                    .collection('tasks')
                    .where('taskSeekerId', isEqualTo: userId)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection('tasks')
                    .where('applicants', arrayContains: userId)
                    .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final tasks = snapshot.data?.docs ?? [];

              if (tasks.isEmpty) {
                return Center(
                    child: Text(isTaskSeeker
                        ? 'No tasks posted.'
                        : 'No applied tasks.'));
              }

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final title = task['title'] ?? '';
                  final description = task['description'] ?? '';
                  final status = task['status'] ?? 'Not Applied';

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(description),
                      trailing: Text(
                        status,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TaskDetailsScreen(taskId: task.id),
                          ),
                        );
                      },
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

  const TaskDetailsScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(taskId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error: Something went wrong.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final task = snapshot.data?.data() as Map<String, dynamic>?;

          if (task == null) {
            return const Center(
              child: Text('Task not found.'),
            );
          }

          final title = task['title'] ?? '';
          final description = task['description'] ?? '';
          final budget = task['budget'] ?? '';
          final image = task['image'] ?? '';
          final status = task['status'] ?? '';

          void updateTaskStatus(String newStatus) {
            FirebaseFirestore.instance
                .collection('tasks')
                .doc(taskId)
                .update({'status': newStatus}).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task status updated')),
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to update task status')),
              );
            });
          }

          void initiatePayment(BuildContext context, String taskId, double amount) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentPage(taskId: taskId, amount: amount),
    ),
  );
}


          final isTaskSeeker = userId == task['taskSeekerId'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (image.isNotEmpty)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16.0),
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
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (status == 'Applied' && isTaskSeeker)
                    ElevatedButton(
                      onPressed: () => updateTaskStatus('Completed'),
                      child: const Text('Mark as Completed'),
                    ),
                  if (status == 'Completed' && isTaskSeeker)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('task_ratings')
                                .where('taskId', isEqualTo: taskId)
                                .snapshots()
                                .listen((snapshot) {
                              if (snapshot.docs.isEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RatingPage(taskId: taskId),
                                  ),
                                );
                              } else {
                                final rating = snapshot.docs[0].data();
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Task Completed'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Performance Ratings'),
                                        Text(
                                          'Communication: ${rating['communication']}',
                                        ),
                                        Text(
                                          'Efficiency: ${rating['efficiency']}',
                                        ),
                                        Text(
                                          'Overall: ${rating['overall']}',
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                          },
                          child: const Text('Rate Performance'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            initiatePayment(context, taskId, budget);
                          },
                          child: const Text('Proceed to Payment'),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  if (status == 'Active' && !isTaskSeeker)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            updateTaskStatus('Completed');
                          },
                          child: const Text('Mark as Completed'),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            initiatePayment(context, taskId, budget);
                          },
                          child: const Text('Initiate Payment'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
