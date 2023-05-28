import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TaskSeekerInterface extends StatefulWidget {
  @override
  _TaskSeekerInterfaceState createState() => _TaskSeekerInterfaceState();
}

class _TaskSeekerInterfaceState extends State<TaskSeekerInterface> {
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  TextEditingController _taskBudgetController = TextEditingController();
  String _imagePath = '';

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
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
              if (_imagePath.isNotEmpty)
                Image.asset(
                  _imagePath,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Code to handle task submission
                },
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
