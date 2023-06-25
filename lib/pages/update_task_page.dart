import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateTaskPage extends StatefulWidget {
  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _taskStream;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    final taskSeekerId = currentUser?.uid;
    _taskStream = FirebaseFirestore.instance
        .collection('tasks')
        .where('taskSeekerId', isEqualTo: taskSeekerId)
        .snapshots();
  }

  void _editTask(String taskId, String title, String description, double budget) {
    setState(() {
      _titleController.text = title;
      _descriptionController.text = description;
      _budgetController.text = budget.toString();
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
              maxLines: 4,
            ),
            TextFormField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Task Budget'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateTask(taskId);
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Confirm Changes'),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteTask(taskId);
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Delete Task'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateTask(String taskId) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final taskSeekerId = currentUser?.uid;

      await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
        'taskSeekerId': taskSeekerId,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'budget': double.parse(_budgetController.text.trim()),
      });

      // Clear the form fields after updating the task
      _titleController.clear();
      _descriptionController.clear();
      _budgetController.clear();
    } catch (e, stackTrace) {
      print('Error updating task: $e');
      print('Stack trace: $stackTrace');
      // Show an error message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while updating the task.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _deleteTask(String taskId) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();

      // Clear the form fields after deleting the task
      _titleController.clear();
      _descriptionController.clear();
      _budgetController.clear();
    } catch (e, stackTrace) {
      print('Error deleting task: $e');
      print('Stack trace: $stackTrace');
      // Show an error message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while deleting the task.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Tasks'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _taskStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!.docs;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index].data();
                final taskId = tasks[index].id;
                final title = task['title'] ?? '';
                final description = task['description'] ?? '';
                final budget = task['budget'] ?? '';

                return ListTile(
                  title: Text(title),
                  subtitle: Text('Budget: $budget'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editTask(taskId, title, description, budget),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }
}