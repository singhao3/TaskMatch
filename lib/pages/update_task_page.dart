import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class UpdateTaskPage extends StatefulWidget {
  final String taskId;

  UpdateTaskPage({required this.taskId});

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  TextEditingController _taskBudgetController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    // Fetch the existing task data from Firestore
    _fetchTaskData();
  }

  Future<void> _fetchTaskData() async {
    try {
      // Retrieve the task document from Firestore
      DocumentSnapshot<Map<String, dynamic>> taskSnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.taskId)
          .get();

      // Extract the task data
      Map<String, dynamic>? taskData = taskSnapshot.data() as Map<String, dynamic>?;

      if (taskData != null) {
        // Populate the form fields with the existing task data
        _taskTitleController.text = taskData['title'];
        _taskDescriptionController.text = taskData['description'];
        _taskBudgetController.text = taskData['budget'].toString();
      }
    } catch (e, stackTrace) {
      print('Error fetching task data: $e');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Update Task',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            TextFormField(
              controller: _taskTitleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _taskDescriptionController,
              decoration: InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _taskBudgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Task Budget',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _uploadImage,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              icon: Icon(Icons.image),
              label: Text(
                'Upload Image',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _updateTask,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Update Task',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _deleteTask,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Delete Task',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _updateTask() async {
    try {
      // Update the task document in Firestore
      await FirebaseFirestore.instance.collection('tasks').doc(widget.taskId).update({
        'title': _taskTitleController.text.trim(),
        'description': _taskDescriptionController.text.trim(),
        'budget': double.parse(_taskBudgetController.text.trim()),
      });

      // Upload the image if it exists
      if (_imageFile != null) {
        await _uploadImageToFirebaseStorage();
      }

      // Show a success message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Task Updated'),
          content: Text('Your task has been successfully updated.'),
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

  void _deleteTask() async {
    try {
      // Delete the task document from Firestore
      await FirebaseFirestore.instance.collection('tasks').doc(widget.taskId).delete();

      // Show a success message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Task Deleted'),
          content: Text('Your task has been successfully deleted.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to previous screen
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
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

  Future<void> _uploadImageToFirebaseStorage() async {
    try {
      // Generate a unique filename for the uploaded image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a reference to the image file in Firebase Storage
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref().child('task_images/$fileName');

      // Upload the image file to Firebase Storage
      await storageRef.putFile(_imageFile!);

      // Get the download URL of the uploaded image
      String downloadURL = await storageRef.getDownloadURL();

      // Update the task document with the download URL
      await FirebaseFirestore.instance.collection('tasks').doc(widget.taskId).update({
        'imageUrl': downloadURL,
      });
    } catch (e, stackTrace) {
      print('Error uploading image: $e');
      print('Stack trace: $stackTrace');
    }
  }
}
