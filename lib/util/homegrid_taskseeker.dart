import 'package:flutter/material.dart';
import 'package:taskmatch/pages/taskseeker/task_seeker_post.dart';

class HomeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: GridView.count(
            crossAxisCount: 1,
            padding: const EdgeInsets.all(20.0),
            childAspectRatio: 1.2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: [
              _buildIconBox(
                context,
                Icons.add,
                'Post a Task',
                Colors.green[400]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildIconBox(BuildContext context, IconData icon, String text, Color color) {
  return GestureDetector(
    onTap: () {
      if (text == 'Post a Task') {
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
