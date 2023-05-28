
import 'package:flutter/material.dart';

class homegrid extends StatelessWidget {

  
  @override
  // Widget build(BuildContext context) {
  //   return GridView.count(
  //     crossAxisCount: 2,
  //     padding: EdgeInsets.all(10),
  //     childAspectRatio: 1.2,
  //     mainAxisSpacing: 40.0,
  //     crossAxisSpacing: 30.0,
  //     children: [
  //       // _buildIconBox(
  //       //   context,
  //       //   Icons.message,
  //       //   'Messages',
  //       //   Colors.blue[400]!,
  //       // ),
  //       // _buildIconBox(
  //       //   context,
  //       //   Icons.person,
  //       //   'Profile',
  //       //   Colors.green[400]!,
  //       // ),
  //       _buildIconBox(
  //         context,
  //         Icons.work,
  //         'Create Task',
  //         Colors.orange[400]!,
  //       ),
  //     ],
  //   );
  // }


Widget build(BuildContext context) {
  return Container(
    color: Colors.green, // Set the background color to green
    child: Center(
      child: FractionallySizedBox(
        widthFactor: 1.0, // Adjust the width of the icon box
        heightFactor: 1.0, // Adjust the height of the icon box
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(20.0),
          childAspectRatio: 1.2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          children: [
            _buildIconBox(
              context,
              Icons.work,
              'Create Task',
              Colors.orange[400]!,
            ),
          ],
        ),
      ),
    ),
  );
}



Widget _buildIconBox(BuildContext context, IconData icon, String text, Color color) {
    return GestureDetector(
      onTap: () {
        if (text == 'Create Task') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskSeekerInterface()),
          );
        } else {
          // Handle other icon box tap
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.white),
            SizedBox(height: 16),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class TaskSeekerInterface extends StatefulWidget {
  @override
  _TaskSeekerInterfaceState createState() => _TaskSeekerInterfaceState();
}

class _TaskSeekerInterfaceState extends State<TaskSeekerInterface> {
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  TextEditingController _taskBudgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Task'),
      ),
      body: Padding(
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
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _taskDescriptionController,
              decoration: InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
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
              ),
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
    );
  }
}
