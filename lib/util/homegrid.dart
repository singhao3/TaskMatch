import 'package:flutter/material.dart';

class homegrid extends StatelessWidget {
  const homegrid({super.key});


@override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // set the number of columns
      children: [
        _buildIconBox(Icons.message, 'Messages', Colors.blue[200]!),
        _buildIconBox(Icons.person, 'Profile', Colors.green[200]!),
        _buildIconBox(Icons.work, 'Task Seeker', Colors.orange[200]!),
      ],
    );
  }

  Widget _buildIconBox(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}