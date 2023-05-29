import 'package:flutter/material.dart';
import 'package:taskmatch/pages/task_seeker_post.dart';
import 'package:taskmatch/pages/my_tasks_page.dart';

class HomeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildIconBox(
                    context,
                    Icons.add,
                    'Post a Task',
                    Colors.green[400]!,
                    TaskSeekerInterface(),
                  ),
                  _buildIconBox(
                    context,
                    Icons.edit,
                    'Update Task Post',
                    Colors.blue[400]!,
                    MyTasksPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildIconBox(BuildContext context, IconData icon, String text, Color color, Widget destination) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
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
