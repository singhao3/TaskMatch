import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class TaskSeekerInterface extends StatefulWidget {
  @override
  _TaskSeekerInterfaceState createState() => _TaskSeekerInterfaceState();
}

class _TaskSeekerInterfaceState extends State<TaskSeekerInterface> {
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  TextEditingController _taskBudgetController = TextEditingController();
  String _imagePath = '';
  File? _imageFile;

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });

      File imageFile = File(pickedImage.path);

      // Display the uploaded image
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Future<void> _postTask() async {
    try {
      // Upload the image to Firebase Storage if an image is selected
      String imageUrl = '';
      if (_imagePath.isNotEmpty) {
        final file = File(_imagePath);
        final imageName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('task_images')
            .child('$imageName.jpg');
        await storageRef.putFile(file);
        imageUrl = await storageRef.getDownloadURL();
      }

      // Create a task document in Firestore
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': _taskTitleController.text.trim(),
        'description': _taskDescriptionController.text.trim(),
        'budget': double.parse(_taskBudgetController.text.trim()),
        'image': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Reset the form fields after posting the task
      _taskTitleController.clear();
      _taskDescriptionController.clear();
      _taskBudgetController.clear();
      setState(() {
        _imagePath = '';
      });

      // Show a success message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Task Posted'),
          content: Text('Your task has been successfully posted.'),
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
    } catch (e) {
      print('Error posting task: $e');
      // Show an error message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while posting the task.'),
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
        title: Text('Post a Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create a Task',
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
              SizedBox(height: 16.0),
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _postTask,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Post Task',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}