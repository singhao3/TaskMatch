import 'package:flutter/material.dart';
import 'package:taskmatch/util/messagegrid.dart';

class message extends StatelessWidget {
  const message({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: messagegrid(),
    );
  }
}