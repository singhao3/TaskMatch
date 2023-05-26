import 'package:flutter/material.dart';
import 'package:taskmatch/util/profilegrid.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      appBar: AppBar(
        title: Text(
          'Task Seeker',
          textAlign: TextAlign.right,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings action
            },
          ),
        ],
      ),
      body: ProfileDashboard(),
    );
  }
}